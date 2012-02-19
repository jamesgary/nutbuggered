NB.Creep.prototype.draw = (ctx) ->
  size = 10
  dim = 32
  offset = (dim - size) / 2

  x = @position[0] * dim
  y = @position[1] * dim
  xOffset = (dim / 2)
  yOffset = (dim / 2)

  ctx.fillStyle = "Black"
  ctx.beginPath()
  ctx.arc(x + xOffset, y + yOffset, size, 0, Math.PI*2, true)
  ctx.closePath()
  ctx.fill()

  height = 3
  healthBarOpts = {
    ctx: ctx
    x: x
    y: y
    width: dim
    height: 3,
    hp: @hp,
    maxHp: @maxHp,
  }
  NB.ViewHelper.drawHealth(healthBarOpts)
