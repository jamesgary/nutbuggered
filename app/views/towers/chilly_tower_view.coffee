NB.ChillyTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) - offset
  y = (@coordinates[1] * dim) - offset
  snowX = (@coordinates[0] * dim) - (offset * 2)
  snowY = (@coordinates[1] * dim) - (offset * 2)

  # draw squirrel
  ctx.drawImage(NB.imageData.chilly, x, y)

  # draw snowflakes
  @age = if @age then 0 else @age + 1

  ctx.drawImage(NB.imageData.snow, snowX, snowY)
  #ctx.drawImage(NB.imageData.snow,
  #  0, 0, 96, 96, # source
  #  snowX, snowY, 96, 96 # destination
  #)

NB.ChillyTower::drawAttack = ->
