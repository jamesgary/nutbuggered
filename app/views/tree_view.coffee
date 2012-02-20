NB.Tree.prototype.draw = (ctx) ->
  healthPercentage = @hp / @maxHp
  nudgeRight = 15

  if healthPercentage == 1
    image = NB.imageData.tree
  else
    image = NB.imageData.tree_dmg1
    if healthPercentage < .66
      image = NB.imageData.tree_dmg2
    if healthPercentage < .33
      image = NB.imageData.tree_dmg3

  ctx.globalAlpha = 0.7
  ctx.drawImage(image, @x + nudgeRight, @y)
  ctx.globalAlpha = 1

  margin = 20
  dim = 160
  topMargin = 15
  healthBarOpts = {
    ctx: ctx,
    x: @x + margin + nudgeRight,
    y: @y + topMargin,
    width: dim - (2 * margin),
    height: 4,
    hp: @hp,
    maxHp: @maxHp,
  }
  NB.ViewHelper.drawHealth(healthBarOpts)
