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
  @age++

  mod = @power || .2 # cheating!
  ageOffsetX = Math.sin(@age / 100) * -100 * @power
  ageOffsetY = (@age * 4 * @power) + 1000
  if @range
    for cell in @range
      ctx.drawImage(NB.imageData.snow,
        # source
        Math.abs(((cell[0] * dim) + ageOffsetX) % 96),
        96 - Math.abs(((cell[1] * -dim) + ageOffsetY) % 96),
        dim, dim,

        # destination
        (cell[0] * dim),
        (cell[1] * dim),
        dim, dim
      )

NB.ChillyTower::drawAttack = ->
