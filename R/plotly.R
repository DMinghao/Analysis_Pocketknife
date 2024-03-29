if (!require(plotly))
  install.packages("plotly")

make_it_spin <- function(plotly_obj,
                          eye = list(x = 1.25,
                                     y = 1.25,
                                     z = 1.25),
                          center = list(x = 0,
                                        y = 0,
                                        z = 0)) {
  plotly_obj %>%
    layout(scene = list(camera = list(eye = eye,
                                      center = center))) %>%
    onRender(
      "
      function(el, x){
  var id = el.getAttribute('id');
  var gd = document.getElementById(id);
  Plotly.update(id).then(attach);
  function attach() {
    var cnt = 0;

    function run() {
      rotate('scene', Math.PI / 1000);
      requestAnimationFrame(run);
    }
    run();

    function rotate(id, angle) {
      var eye0 = gd.layout[id].camera.eye
      var rtz = xyz2rtz(eye0);
      rtz.t += angle;

      var eye1 = rtz2xyz(rtz);
      Plotly.relayout(gd, id + '.camera.eye', eye1)
    }

    function xyz2rtz(xyz) {
      return {
        r: Math.sqrt(xyz.x * xyz.x + xyz.y * xyz.y),
        t: Math.atan2(xyz.y, xyz.x),
        z: xyz.z
      };
    }

    function rtz2xyz(rtz) {
      return {
        x: rtz.r * Math.cos(rtz.t),
        y: rtz.r * Math.sin(rtz.t),
        z: rtz.z
      };
    }
  };
}
    ")
}