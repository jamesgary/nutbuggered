NB.SlingshotTower = class SlingshotTower extends NB.Tower
  constructor: (@coordinates) ->
    data = NB.towerData.SlingshotTower()
    super(data)
  attack: ->
    creepsForEachRange = NB.Director.level.findCreep({range: @range})
    if creeps = creepsForEachRange[0]
      if creep = creeps[0]
        creep.damage(@power)
        attacked = true
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
