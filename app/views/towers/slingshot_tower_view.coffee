NB.SlingshotTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  # draw squirrel
  ctx.save()

  # look at a creep
  #creep = NB.Director.level.findCreep

  ctx.translate(x, y)
  # probably gonna have to rotate to point at creep
  ctx.drawImage(NB.imageData.slingshot, -2 * offset, -2 * offset)
  ctx.restore()

NB.SlingshotTower.prototype.drawAttack = ->
