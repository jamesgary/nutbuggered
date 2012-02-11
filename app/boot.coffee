(exports ? this).NB = {}
files = [
  # models
  "js/compiled/models/arc.js",
  "js/compiled/models/creep.js",
  "js/compiled/models/director.js",
  "js/compiled/models/grid.js",
  "js/compiled/models/level.js",
  "js/compiled/models/map.js",
  "js/compiled/models/path.js",
  "js/compiled/models/stage.js",
  "js/compiled/models/tower.js",
  "js/compiled/models/wave.js",

  "js/compiled/models/creeps/creep.js",
  "js/compiled/models/towers/tower.js",
  "js/compiled/models/towers/boxer_tower.js",

  # views
  "js/compiled/views/level_view.js",
  "js/compiled/views/map_view.js",
  "js/compiled/views/wave_view.js",

  "js/compiled/views/creeps/creep_view.js",

  # other
  "js/compiled/controller.js",
]
require files, ->
  console.log("* All loaded, sir!")
  if (typeof jasmine == 'undefined')
    waveData1 = {creepData: {type: NB.Creep, hpMod: 1, speedMod: 1, countMod: 1, waitMod: 1}}
    waveData2 = {creepData: {type: NB.Creep, hpMod: 1.2, speedMod: 1.2, countMod: .8, waitMod: .8}}
    waveData3 = {creepData: {type: NB.Creep, hpMod: 2.5, speedMod: 2.5, countMod: 2.5, waitMod: 1}}
    path = new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]])
    map = new NB.Map(path)
    levelData = {wavesData: [waveData1, waveData2, waveData3], map: map}
    level = new NB.Level(levelData)

    NB.Director.start({level: level})
    NB.Controller.loadAll()
