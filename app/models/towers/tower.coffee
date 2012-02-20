NB.Tower = class Tower
  constructor: (data) ->
    @cost = data.cost
    @upgrades = data.upgrades
    @ticksUntilAttack = 0
    @priority = NB.Priorities.FIRST
    @shouldDrawRange = false #TODO move to view
    @projectiles = []
    @canPrioritize = true
    @age = 0

    @canUpgradePower   = !!(@upgrades.power)
    @canUpgradeRange   = !!(@upgrades.range)
    @canUpgradeSpeed   = !!(@upgrades.speed)
    @canUpgradeSpecial = !!(@upgrades.special)
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

  refreshRange: ->
    x = @coordinates[0]
    y = @coordinates[1]
    if @radius
      @range = []
      for newX in [x-@radius..x+@radius]
        for newY in [y-@radius..y+@radius]
          @range.push [newX, newY]
  nextRangeUpgrade: ->
    @upgrades.range[0] || null
  upgradeRange: ->
    if @coordinates
      @radius = @upgrades.range[0].sq
      @refreshRange()
    @upgrades.range.shift()

  nextSpeedUpgrade: ->
    @upgrades.speed[0] || null
  upgradeSpeed: ->
    @speed = @upgrades.speed[0].rate
    @cooldown = 60 * @speed # 60 FPS
    @upgrades.speed.shift()

  nextSpecialUpgrade: ->
    @upgrades.special[0] || null

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
