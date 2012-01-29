NB.Director = {
  FPS: 60
  start: ->
    @stage = new NB.Stage()
    @stage.load(new NB.Map())
    @tickerInterval = setInterval(@tick, 1000 / @FPS)
  tick: ->
    @stage.tick()
  end: ->
    if @tickerInterval
      clearInterval(@tickerInterval)
}
