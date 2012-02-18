NB.Tower::drawRange = (ctx) ->
  dim = 32
  if @range && @shouldDrawRange
    for cell in @range
      ctx.fillStyle = "rgba(255,255,255,.3)"
      ctx.fillRect((cell[0] * dim), (cell[1] * dim), dim, dim)

NB.Tower::drawUpgrades = ->
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
    $range.find('.orig').text(@radius)

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

NB.Tower::undrawUpgrades = ->
  $('#upgrades').hide()