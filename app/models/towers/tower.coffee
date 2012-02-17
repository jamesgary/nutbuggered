NB.Tower = class Tower
  constructor: (data) ->
    @cost = data.cost
    @upgrades = data.upgrades
    @ticksUntilAttack = 0
    @shouldDrawRange = false #TODO move to view

    @canUpgradePower = !!(@upgrades.power)
    @canUpgradeRange = !!(@upgrades.range)
    @canUpgradeSpeed = !!(@upgrades.speed)
    @upgradePower() if @canUpgradePower
    @upgradeRange() if @canUpgradeRange
    @upgradeSpeed() if @canUpgradeSpeed
  tick: ->
    if @ticksUntilAttack > 0
      @ticksUntilAttack--
    else
      if @attack() # only reset if attack
        @ticksUntilAttack = @cooldown
  attack: -> console.error('Error: Called NB.Tower#attack')

  ##############
  #  UPGRADES  #
  ##############

  nextPowerUpgrade: ->
    @upgrades.power[0] || null
  upgradePower: ->
    @power = @upgrades.power[0].dmg
    @upgrades.power.shift()

  nextRangeUpgrade: ->
    @upgrades.range[0] || null
  upgradeRange: ->
    sq = @upgrades.range[0].sq
    x = @coordinates[0]
    y = @coordinates[1]
    @range = []
    for newX in [x-sq..x+sq]
      for newY in [y-sq..y+sq]
        @range.push [newX, newY]
    @upgrades.range.shift()

  nextSpeedUpgrade: ->
    @upgrades.speed[0] || null
  upgradeSpeed: ->
    @speed = @upgrades.speed[0].rate
    @cooldown = 60 * @speed # 60 FPS
    @upgrades.speed.shift()

  ######
  # UX #
  ######

  clicked: ->
    @shouldDrawRange = true
    unless @hovering
      @drawUpgrades()
  unclick: ->
    @shouldDrawRange = false
    @undrawUpgrades()
