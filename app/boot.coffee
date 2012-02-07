(exports ? this).NB = {}
files = [
  "js/compiled/models/grid.js",
  "js/compiled/models/map.js",
  "js/compiled/models/tower.js",
  "js/compiled/models/director.js",
  "js/compiled/models/stage.js",
  "js/compiled/models/creep.js",
  "js/compiled/models/path.js",
  "js/compiled/models/arc.js",
  "js/compiled/models/level.js",
  "js/compiled/models/wave.js",

  "js/compiled/views/map_view.js",
  "js/compiled/views/level_view.js",
  "js/compiled/views/wave_view.js",
  "js/compiled/views/creep_view.js",

  "js/compiled/controller.js",
]
require files, ->
  console.log("* All loaded, sir!")
  if (typeof jasmine == 'undefined')
    NB.Director.start()
