NB.BoxerTower = class BoxerTower extends NB.Tower
  constructor: (@coordinates, @direction) ->
    data = NB.towerData.BoxerTower
    @cost = data.cost
    @upgrades = data.upgrades
    @cooldown = 60
    @ticksUntilAttack = 0
    x = @coordinates[0]
    y = @coordinates[1]
    @range = [
      switch @direction
        when 'n' then [x, y-1]
        when 'e' then [x+1, y]
        when 's' then [x, y+1]
        when 'w' then [x-1, y]
    ]
    @shouldDrawRange = false

    @upgradePower()
    @upgradeSpeed()
  tick: ->
    if @ticksUntilAttack > 0
      @ticksUntilAttack--
    else
      @attack()
      @ticksUntilAttack = @cooldown
  attack: ->
    creepsForEachRange = NB.Director.level.findCreep({range: @range})
    for creeps in creepsForEachRange
      creep.damage(20) for creep in creeps
    @ticksUntilAttack = @cooldown

  canUpgradePower: -> true
  nextPowerUpgrade: ->
    @upgrades.power[0]
  upgradePower: ->
    @power = @upgrades.power[0].dmg
    @upgrades.power.shift()

  canUpgradeRange: -> false

  canUpgradeSpeed: -> true
  nextSpeedUpgrade: ->
    @upgrades.speed[0]
  upgradeSpeed: ->
    @speed = @upgrades.speed[0].rate
    @upgrades.speed.shift()

  clicked: ->
    @shouldDrawRange = true
    unless @hovering
      @drawUpgrades()
  unclick: ->
    @shouldDrawRange = false
    @undrawUpgrades()

NB.BoxerTowerPlaceholder = class BoxerTowerPlaceholder extends NB.BoxerTower
  constructor: (@coordinates) ->
    @direction = 's'
    @cost = 0
    unless @coordinates
      @hovering = true
    @shouldDrawRange = true
  tick: -> # just don't shoot!
    # TODO: Memoize if possible
    x = @coordinates[0]
    y = @coordinates[1]
    @range = [
      switch @direction
        when 'n' then [x, y-1]
        when 'e' then [x+1, y]
        when 's' then [x, y+1]
        when 'w' then [x-1, y]
    ]
  clicked: ->
    super()
    @undrawUpgrades()
  draw: (ctx) ->
    unless @hasDrawn && @coordinates
      size = 64
      dim = 32
      offset = (dim - size) / 2
      x = (@coordinates[0] * dim) - offset
      y = (@coordinates[1] * dim) - offset

      unless @hovering
        dpad_img_size = 250
        offset = dpad_img_size / -2
        $('#dpad').css('background-position-x', x + offset)
        $('#dpad').css('background-position-y', y + offset)
        $('#dpad').show()
        @hasDrawn = true
    super(ctx)
  promote: ->
    new NB.BoxerTower(@coordinates, @direction)
