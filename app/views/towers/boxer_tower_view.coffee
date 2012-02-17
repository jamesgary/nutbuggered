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
  totalTurn = quarterTurns * 90
  if @punchRotationDirection
    if @ticksUntilAttack > 0 # cooling down, wind back
      totalTurn += @punchRotationDirection * Math.pow(@ticksUntilAttack / @cooldown, 7) * 60

  rotation = (totalTurn * Math.PI / 180)
  ctx.rotate(rotation)
  ctx.drawImage(NB.imageData.boxer, -2 * offset, -2 * offset)
  ctx.restore()

NB.BoxerTower.prototype.drawUpgrades = ->
  #FIXME Refactor!!!!!
  tower = this

  $power = $('#upgrades .power')
  if @canUpgradePower
    $power.find('.can_upgrade').show()
    $power.find('.cannot_upgrade').hide()
    $power.find('.orig').text(@power)

    nextUpgrade = @nextPowerUpgrade()
    if nextUpgrade == null # maxed out
      $power.find('.not_maxed').hide()
    else
      powerCost = nextUpgrade.cost
      dmg = nextUpgrade.dmg
      $power.find('.not_maxed').show()
      $power.find('.new').text(dmg)
      $power.find('.cost').text(powerCost)
      $power.off('click', '.button')
      $power.on('click', '.button', (e) ->
        console.log(powerCost)
        if NB.Director.level.canAfford(powerCost)
          NB.Director.level.chargeMoney(powerCost)
          tower.upgradePower()
          tower.drawUpgrades()
      )
  else
    $power.find('.can_upgrade').hide()
    $power.find('.cannot_upgrade').show()

  $speed = $('#upgrades .speed')
  if @canUpgradeSpeed
    $speed.find('.can_upgrade').show()
    $speed.find('.cannot_upgrade').hide()
    $speed.find('.orig').text(@speed)

    nextUpgrade = @nextSpeedUpgrade()
    if nextUpgrade == null # maxed out
      $speed.find('.not_maxed').hide()
    else
      speedCost = nextUpgrade.cost
      rate = nextUpgrade.rate
      $speed.find('.not_maxed').show()
      $speed.find('.new').text(rate)
      $speed.find('.cost').text(speedCost)
      $speed.off('click', '.button')
      $speed.on('click', '.button', (e) ->
        console.log(speedCost)
        if NB.Director.level.canAfford(speedCost)
          NB.Director.level.chargeMoney(speedCost)
          tower.upgradeSpeed()
          tower.drawUpgrades()
      )
  else
    $speed.find('.can_upgrade').hide()
    $speed.find('.cannot_upgrade').show()


  $range = $('#upgrades .range')
  if @canUpgradeRange
    $range.find('.can_upgrade').show()
    $range.find('.cannot_upgrade').hide()
    $range.find('.orig').text(@range)

    nextUpgrade = @nextRangeUpgrade()
    if nextUpgrade == null # maxed out
      $range.find('.not_maxed').hide()
    else
      $range.find('.not_maxed').show()
      $range.find('.new').text(nextUpgrade.sq)
      $range.find('.cost').text(nextUpgrade.cost)
      $range.off('click', '.button')
      $range.on('click', '.button', (e) ->
        tower.upgradeRange()
        tower.drawUpgrades()
      )
  else
    $range.find('.can_upgrade').hide()
    $range.find('.cannot_upgrade').show()

  $('#upgrades').show()

NB.BoxerTower.prototype.undrawUpgrades = ->
  $('#upgrades').hide()

NB.BoxerTower.prototype.drawAttack = ->
  rotateSide = if Math.random() > .5 then 1 else -1
  @punchRotationDirection = rotateSide
