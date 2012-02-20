NB.Creep::draw = (ctx) ->
  @size = @size || 10
  @color = @color || "Black"
  @xFudge = @xFudge || 10 - (20 * Math.random())
  @yFudge = @yFudge || 10 - (20 * Math.random())
  @dim = 32
  offset = (@dim - @size) / 2

  x = @position[0] * @dim
  y = @position[1] * @dim

  @drawBug(ctx)

  height = 3
  healthBarOpts = {
    ctx: ctx
    x: x + @xFudge
    y: y + @yFudge
    width: @dim
    height: 3
    hp: @hp
    maxHp: @maxHp
  }
  NB.ViewHelper.drawHealth(healthBarOpts)

NB.Creep::drawBug = (ctx) ->
  x = @position[0] * @dim
  y = @position[1] * @dim
  xOffset = (@dim / 2) + @xFudge
  yOffset = (@dim / 2) + @yFudge

  ctx.fillStyle = @color
  ctx.beginPath()
  ctx.arc(x + xOffset, y + yOffset, @size, 0, Math.PI*2, true)
  ctx.closePath()
  ctx.fill()

NB.Ant = class NB.Ant extends NB.Creep
  draw: (ctx) ->
    @color = "#291606"
    @size = 3
    super(ctx)
  drawBug: (ctx) ->
    x = @position[0] * @dim
    y = @position[1] * @dim
    xOffset = (@dim / 2) + @xFudge
    yOffset = (@dim / 2) + @yFudge

    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.arc(x + xOffset, y + yOffset, @size, 0, Math.PI*2, true)
    ctx.closePath()
    ctx.fill()
