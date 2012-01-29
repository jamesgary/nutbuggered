NB.Director = {
  start: ->
    @stage = new NB.Stage()
    @stage.load(new NB.Map())
  tick: ->
    @stage.tick()
}
