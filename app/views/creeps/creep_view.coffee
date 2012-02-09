NB.Creep.prototype.draw = (ctx) ->
  size = 10
  dim = 32
  offset = (dim - size) / 2
  #ctx.fillRect((@position[0] * dim) + offset, (@position[1] * dim) + offset, size, size)

  x = @position[0] * dim
  y = @position[1] * dim
  xOffset = (dim / 2)
  yOffset = (dim / 2)

  ctx.beginPath()
  ctx.arc(x + xOffset, y + yOffset, size, 0, Math.PI*2, true)
  ctx.closePath()
  ctx.fill()
