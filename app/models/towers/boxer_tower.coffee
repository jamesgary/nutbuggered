NB.BoxerTower = class BoxerTower extends NB.Tower
  constructor: (@coordinates, @direction) ->
    @cost = 50
    x = @coordinates[0]
    y = @coordinates[1]
    @range = [
      switch @direction
        when 'n' then [x, y-1]
        when 'e' then [x+1, y]
        when 's' then [x, y+1]
        when 'w' then [x-1, y]
    ]
  tick: ->
    creeps = NB.currentLevel.findCreep({range: @range})
    creeps = creeps[0]
    creep.damage(20) for creep in creeps
