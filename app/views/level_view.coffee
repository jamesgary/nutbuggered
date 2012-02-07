NB.Level.prototype.drawInit = ->
  @canvas = document.getElementById('foreground')
  @ctx = @canvas.getContext("2d")
NB.Level.prototype.draw = ->
  @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
  wave.draw(@ctx) for wave in @currentWaves
