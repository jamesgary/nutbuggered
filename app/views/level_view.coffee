NB.Level.prototype.drawInit = ->
  @canvas = document.getElementById('foreground')
  @ctx = @canvas.getContext("2d")
  @map.drawInit()
NB.Level.prototype.draw = ->
  $('#money').html(@money)
  @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
  wave.draw(@ctx) for wave in @currentWaves
  @map.draw(@ctx)
