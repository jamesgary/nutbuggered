NB.BoxerTower::draw = (ctx) ->
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
  if @range.length >= 8 # roundhouse time!
    percentage = @ticksUntilAttack / @cooldown
    # first half is kicking, second half is at rest
    if percentage < .5
      totalTurn += @punchRotationDirection * Math.pow(2*percentage, 2) * 360
  else
    if @punchRotationDirection
      if @ticksUntilAttack > 0 # cooling down, wind back
        totalTurn += @punchRotationDirection * Math.pow(@ticksUntilAttack / @cooldown, 7) * 60

  rotation = (totalTurn * Math.PI / 180)
  ctx.rotate(rotation)
  ctx.drawImage(NB.imageData.boxer, -2 * offset, -2 * offset)
  ctx.restore()

NB.BoxerTower.prototype.drawAttack = ->
  rotateSide = if Math.random() > .5 then 1 else -1
  @punchRotationDirection = rotateSide
