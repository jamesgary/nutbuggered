NB.ChillyTower = class ChillyTower extends NB.Tower
  constructor: (@coordinates) ->
    data = NB.towerData.ChillyTower()
    super(data)
    @ticksUntilAttack = @cooldown
    @canPrioritize = false
  attack: ->
    creeps = NB.Director.level.findCreep(
      range: @range
    )
    creep.slow(@power) for creep in creeps
    attacked = creeps.length > 0
    return attacked
  tick: ->
    @attack()

NB.ChillyTowerPlaceholder = class ChillyTowerPlaceholder extends NB.ChillyTower
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
    new NB.ChillyTower(@coordinates)
