NB.Level.prototype.drawInit = ->
  @canvas = document.getElementById('foreground')
  @ctx = @canvas.getContext("2d")
  @map.drawInit()
NB.Level.prototype.draw = ->
  @moveNeedle()
  $('#money').html(@money)
  @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
  wave.draw(@ctx) for wave in @currentWaves
  @map.draw(@ctx)
NB.Level.prototype.moveNeedle = ->
  waveHeight = 42 # from style.css
  $('#needle').css('top', pos)
  if (@currentWaveIndex == 0)
    pos = 0
  else
    pos = ((@currentWaveIndex - 1) * waveHeight)
    unless (@waves.isEmpty())
      pos += 42 * (@currentWaveAge / @waveLifespan)

  $('#needle').css('top', parseInt(pos))
