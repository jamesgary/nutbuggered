NB.ChillyTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) - offset
  y = (@coordinates[1] * dim) - offset

  # draw squirrel
  ctx.drawImage(NB.imageData.chilly, x, y)

NB.ChillyTower::drawAttack = ->
