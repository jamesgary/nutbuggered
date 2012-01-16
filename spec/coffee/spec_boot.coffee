require ["../../nutbuggered/js/compiled/boot.js"], ->
  console.log("App is loaded")
  require ["../js/compiled/grid_spec.js"], ->
    console.log("Specs are loaded")
