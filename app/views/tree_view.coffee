NB.Tree.prototype.draw = (ctx) ->
  healthPercentage = @hp / @maxHp

  if healthPercentage == 1
    image = NB.imageData.tree
  else
    image = NB.imageData.tree_dmg1
    if healthPercentage < .66
      image = NB.imageData.tree_dmg2
    if healthPercentage < .33
      image = NB.imageData.tree_dmg3

  ctx.drawImage(image, @x + 15, @y)

  margin = 20
  dim = 160
  topMargin = 15
  healthBarOpts = {
    ctx: ctx,
    x: @x + margin,
    y: @y + topMargin,
    width: dim - (2 * margin),
    height: 4,
    hp: @hp,
    maxHp: @maxHp,
  }
  NB.ViewHelper.drawHealth(healthBarOpts)
