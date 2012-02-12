NB.Director = {
  FPS: 60
  start: (levelData) ->
    @stage = new NB.Stage()
    @stage.load(levelData.level)

    @tick()
    @level = levelData.level
  tick: ->
    webkitRequestAnimationFrame(NB.Director.tick)
    NB.Director.stage.tick()
    NB.Director.stage.draw()

  sendWave: ->
    @level.sendNextWave()
  placeTower: (tower, coordinates) ->
    @level.placeTower(tower, coordinates)
}
