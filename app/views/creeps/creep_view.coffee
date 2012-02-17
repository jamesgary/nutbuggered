NB.Creep.prototype.draw = (ctx) ->
  size = 10
  dim = 32
  offset = (dim - size) / 2
  #ctx.fillRect((@position[0] * dim) + offset, (@position[1] * dim) + offset, size, size)

  x = @position[0] * dim
  y = @position[1] * dim
  xOffset = (dim / 2)
  yOffset = (dim / 2)

  ctx.fillStyle = "Black"
  ctx.beginPath()
  ctx.arc(x + xOffset, y + yOffset, size, 0, Math.PI*2, true)
  ctx.closePath()
  ctx.fill()

  hpBarHeight = 3
  hpBarWidth = dim
  border = 1
  #border
  ctx.fillStyle = "#000000"
  ctx.fillRect(
    x - border,
    y - border,
    hpBarWidth + (2 * border),
    hpBarHeight + (2 * border)
  )
  #health
  ctx.fillStyle = "#00ff00"
  ctx.fillRect(x, y, hpBarWidth, hpBarHeight)
  #damage
  if (@hp < @maxHp)
    ctx.fillStyle = "#ff0000"
    ctx.fillRect(x, y, ((@maxHp - @hp) / @maxHp) * hpBarWidth, hpBarHeight)
