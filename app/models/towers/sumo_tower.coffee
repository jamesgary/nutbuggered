NB.SumoTower = class SumoTower extends NB.Tower
  constructor: (@coordinates) ->
    data = NB.towerData.SumoTower()
    super(data)
    @ticksUntilAttack = @cooldown
    @shikoRotationDirection = 1
  attack: ->
    creeps = NB.Director.level.findCreep(
      range: @range
    )
    creep.damage(@power) for creep in creeps
    attacked = creeps.length > 0
    if attacked
      @drawAttack(creeps[0])
    return attacked
  tick: ->
    creeps = NB.Director.level.findCreep(
      range: @range
    )
    if creeps.length > 0
      if @ticksUntilAttack > 0
        @ticksUntilAttack--
      else
        if @attack() # only reset if attack
          @ticksUntilAttack = @cooldown
    else # no creeps in range
      if 0 < @ticksUntilAttack < @cooldown # in the middle of shiko
        @ticksUntilAttack--
      else
        @ticksUntilAttack = @cooldown

NB.SumoTowerPlaceholder = class SumoTowerPlaceholder extends NB.SumoTower
  constructor: (@coordinates) ->
    @cost = 0
    @radius = 1
    unless @coordinates
      @hovering = true
    @shouldDrawRange = true
    @shikoRotationDirection = 1
  tick: -> # just don't shoot!
  clicked: ->
    super()
    NB.Director.setPlaceholderTower()
  drawUpgrades: -> # don't draw them
  promote: ->
    new NB.SumoTower(@coordinates)
