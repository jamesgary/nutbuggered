NB.Director = {
  FPS: 60
  start: ->
    @stage = new NB.Stage()
    @stage.load(new NB.Map())
    @tick()
  tick: ->
    webkitRequestAnimationFrame(NB.Director.tick)
    NB.Director.stage.tick()
}
