NB.SlingshotTower = class SlingshotTower extends NB.Tower
  constructor: (@coordinates) ->
    data = NB.towerData.SlingshotTower()
    super(data)
  attack: ->
    creeps = NB.Director.level.findCreep(
      range: @range
      limit: 1
      priority: @priority
    )
    creep.damage(@power) for creep in creeps
    attacked = creeps.length > 0
    if attacked
      @drawAttack()
    return attacked

NB.SlingshotTowerPlaceholder = class SlingshotTowerPlaceholder extends NB.SlingshotTower
  constructor: (@coordinates) ->
    @cost = 0
    @radius = 1
    unless @coordinates
      @hovering = true
    @shouldDrawRange = true
  tick: -> # just don't shoot!
  clicked: ->
    super()
    NB.Director.setPlaceholderTower()
    #@undrawUpgrades()
  drawUpgrades: -> # don't draw them
  promote: ->
    new NB.SlingshotTower(@coordinates)
