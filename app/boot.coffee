(exports ? this).NB = {}
files = [
  "js/compiled/grid.js",
  "js/compiled/map.js",
  "js/compiled/tower.js",
]
require files, ->
  console.log("* All loaded, sir!")
