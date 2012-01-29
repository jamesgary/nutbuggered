spec_files = [
  "../js/compiled/models/grid_spec.js",
  "../js/compiled/models/map_spec.js",
  "../js/compiled/models/tower_spec.js",
  "../js/compiled/models/director_spec.js",
  "../js/compiled/models/stage_spec.js",
  "../js/compiled/views/map_view_spec.js",
]
require ["../../nutbuggered/js/compiled/boot.js"], ->
  console.log("App is loaded")
  require spec_files, ->
    console.log("Specs are loaded")
