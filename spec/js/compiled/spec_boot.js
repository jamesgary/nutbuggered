(function() {

  require(["../../nutbuggered/js/compiled/boot.js"], function() {
    console.log("App is loaded");
    return require(["../js/compiled/grid_spec.js"], function() {
      return console.log("Specs are loaded");
    });
  });

}).call(this);
