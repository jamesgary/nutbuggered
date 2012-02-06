NB.Director = {
  FPS: 60
  start: ->
    NB.mainElement = document.getElementById('main')
    @stage = new NB.Stage()
    NB.currentMap = new NB.Map()
    @stage.load(NB.currentMap)
    @tick()
  tick: ->
    webkitRequestAnimationFrame(NB.Director.tick)
    NB.Director.stage.tick()
}
