NB.BazookaTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  # draw squirrel
  ctx.save()
  ctx.translate(x, y)
  quarterTurns = switch @direction
    when 'n' then 2
    when 'e' then 3
    when 's' then 0
    when 'w' then 1
  totalTurn = quarterTurns * 90

  rotation = (totalTurn * Math.PI / 180)
  ctx.rotate(rotation)
  ctx.drawImage(NB.imageData.bazooka, -3 * offset, -3 * offset)
  ctx.restore()

NB.BazookaTower::drawAttack = ->
  rotateSide = if Math.random() > .5 then 1 else -1
  @punchRotationDirection = rotateSide