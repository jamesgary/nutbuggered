NB.Director = {
  FPS: 60
  start: ->
    NB.mainElement = document.getElementById('main')
    @stage = new NB.Stage()
    NB.currentMap = new NB.Map()
    @stage.load(NB.currentMap)
    NB.controller = new NB.Controller()

    @waveData1 = {creepData: {type: NB.Creep, hpMod: 1, speedMod: 1, countMod: 1, waitMod: 1}}
    @waveData2 = {creepData: {type: NB.Creep, hpMod: 1.2, speedMod: 1.2, countMod: .8, waitMod: .8}}
    @waveData3 = {creepData: {type: NB.Creep, hpMod: 2.5, speedMod: 2.5, countMod: 2.5, waitMod: 1}}
    levelData = {waves: [@waveData1, @waveData2, @waveData3]}
    @currentLevel = new NB.Level(levelData)

    @stage.load(@currentLevel)

    @tick()
  tick: ->
    webkitRequestAnimationFrame(NB.Director.tick)
    NB.Director.stage.tick()
    NB.Director.stage.draw()

  sendWave: ->
    @currentLevel.sendNextWave()
  placeTower: (coordinates)->
    @currentLevel.sendNextWave()
}
