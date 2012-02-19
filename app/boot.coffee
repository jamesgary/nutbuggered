(exports ? this).NB = {}

files = [
  "js/vendor/jquery.js",

  # models
  "js/compiled/models/arc.js",
  "js/compiled/models/creep.js",
  "js/compiled/models/director.js",
  "js/compiled/models/grid.js",
  "js/compiled/models/level.js",
  "js/compiled/models/map.js",
  "js/compiled/models/path.js",
  "js/compiled/models/priorities.js",
  "js/compiled/models/stage.js",
  "js/compiled/models/tree.js",
  "js/compiled/models/tower.js",
  "js/compiled/models/wave.js",

  "js/compiled/models/creeps/creep.js",
  "js/compiled/models/towers/tower.js",
  "js/compiled/models/towers/boxer_tower.js",
  "js/compiled/models/towers/slingshot_tower.js",
  "js/compiled/models/towers/sumo_tower.js",

  # views
  "js/compiled/views/view_helper.js",
  "js/compiled/views/level_view.js",
  "js/compiled/views/map_view.js",
  "js/compiled/views/wave_view.js",
  "js/compiled/views/tree_view.js",

  "js/compiled/views/creeps/creep_view.js",
  "js/compiled/views/towers/tower_view.js",
  "js/compiled/views/towers/boxer_tower_view.js",
  "js/compiled/views/towers/slingshot_tower_view.js",
  "js/compiled/views/towers/sumo_tower_view.js",

  # data
  "js/compiled/data/image_data.js",
  "js/compiled/data/level_data.js",
  "js/compiled/data/tower_data.js",

  # other
  "js/compiled/controller.js",
  "js/compiled/lib.js",
  "js/vendor/pokki/PokkiBrowser.js",
  "js/vendor/pokki/LocalStore.js",
  "js/vendor/pokki/GAPokki.js",
  "js/compiled/pokki.js",
]
require files, ->
  console.log("* All loaded, sir!")

  if (typeof jasmine == 'undefined')
    NB.Director.start()
    NB.Controller.loadAll()
    NB.imageData.loadAll()
