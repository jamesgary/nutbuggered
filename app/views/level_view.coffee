NB.Level::drawInit = ->
  @canvas     = document.getElementById('foreground')
  @treeCanvas = document.getElementById('treeground')
  @ctx     = @canvas.getContext("2d")
  @treeCtx = @treeCanvas.getContext("2d")
  @map.drawInit()
NB.Level::draw = ->
  @moveNeedle()
  $('#money').html(@money)

  # clear canvas
  @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
  @treeCtx.clearRect(0, 0, @treeCanvas.width, @treeCanvas.height)
  # draw canvas
  wave.draw(@ctx) for wave in @currentWaves
  @map.draw(@ctx)

  if @swatter
    # draw range
    dim = 32
    @ctx.fillStyle = "rgba(255,255,255,.3)"
    @ctx.fillRect(cell[0], cell[1], dim, dim) for cell in @swatter.range

    if @swatter.swatted
      @swatter.hitLength = 5
    if @swatter.hitLength && @swatter.hitLength > 0
      @ctx.drawImage(NB.imageData.swatterHit, @swatter.x - 24, @swatter.y - 24)
      @swatter.hitLength--
      @swatter.swatted = false
    else
      @ctx.drawImage(NB.imageData.swatter, @swatter.x - 24, @swatter.y - 24)

  @tree.draw(@treeCtx)
  if @eraseCoordinates
    size = 70
    @treeCtx.clearRect(@eraseCoordinates[0] - size/2, @eraseCoordinates[1] - size/2, size, size)

NB.Level::moveNeedle = ->
  waveHeight = 42 # from style.css
  $('#needle').css('top', pos)
  if (@currentWaveIndex == 0)
    pos = 0
  else
    pos = ((@currentWaveIndex - 1) * waveHeight)
    unless (@waves.isEmpty())
      pos += 42 * (@currentWaveAge / @waveLifespan)

  $('#needle').css('top', parseInt(pos))

NB.Level::erase = (coordinates) ->
  @eraseCoordinates = coordinates
