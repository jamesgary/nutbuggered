(exports ? this).NB = {}
files = [
  "js/compiled/grid.js",
  "js/compiled/map.js",
]
require files, ->
  console.log("* All loaded, sir!")
