files = [
  "../js/compiled/grid_spec.js",
  "../js/compiled/map_spec.js",
  "../js/compiled/tower_spec.js",
]
require ["../../nutbuggered/js/compiled/boot.js"], ->
  console.log("App is loaded")
  require files, ->
    console.log("Specs are loaded")
