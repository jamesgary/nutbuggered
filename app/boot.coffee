(exports ? this).NB = {}
files = [
  "js/compiled/models/grid.js",
  "js/compiled/models/map.js",
  "js/compiled/models/tower.js",
  "js/compiled/views/map_view.js",
  "js/compiled/models/director.js",
  "js/compiled/models/stage.js",
]
require files, ->
  console.log("* All loaded, sir!")
  if (typeof jasmine == 'undefined')
    NB.Director.start()
