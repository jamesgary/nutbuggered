NB.BoxerTower.prototype.draw = (ctx) ->
  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  ctx.save()
  ctx.translate(x, y)
  quarterTurns = switch @direction
    when 'n' then 2
    when 'e' then 3
    when 's' then 0
    when 'w' then 1
  ctx.rotate(quarterTurns * 90 * Math.PI / 180)
  ctx.drawImage(NB.imageData.boxer, -2 * offset, -2 * offset)
  ctx.restore()
