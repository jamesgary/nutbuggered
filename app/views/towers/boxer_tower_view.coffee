NB.BoxerTower.prototype.draw = (ctx) ->
  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  # draw range
  if @range && @shouldDrawRange
    for cell in @range
      ctx.fillStyle = "rgba(255,255,255,.3)"
      ctx.fillRect((cell[0] * dim), (cell[1] * dim), dim, dim)

  # draw squirrel
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

NB.BoxerTower.prototype.drawUpgrades = () ->
  console.log('draw them upgrades!')

NB.BoxerTower.prototype.undrawUpgrades = () ->
  console.log('hide them upgrades!')
