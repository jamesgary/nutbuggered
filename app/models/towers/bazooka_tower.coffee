NB.BazookaTower = class BazookaTower extends NB.Tower
  constructor: (@coordinates, @direction) ->
    data = NB.towerData.BazookaTower()
    super(data)
    @pierceLimit = 5

    x = @coordinates[0]
    y = @coordinates[1]
    @canPrioritize = false
  attack: ->
    creeps = NB.Director.level.findCreep(
      range: @range
      limit: @pierceLimit
    )
    creep.damage(@power) for creep in creeps
    attacked = creeps.length > 0
    if attacked
      @drawAttack(creeps[0])
    return attacked

  refreshRange: ->
    x = @coordinates[0]
    y = @coordinates[1]
    @range = []
    for i in [1..@radius]
      @range.push(
        switch @direction
          when 'n' then [x, y-i]
          when 'e' then [x+i, y]
          when 's' then [x, y+i]
          when 'w' then [x-i, y]
      )
  nextRangeUpgrade: ->
    @upgrades.range[0] || null
  upgradeRange: ->
    if @coordinates
      @radius = @upgrades.range[0].sq
      @refreshRange()
    @upgrades.range.shift()

  upgradeSpecial: ->
    if @upgrades.special.length == 2 # first upgrade
      @pierceLimit = 10
    else
      @pierceLimit = 25
    @upgrades.special.shift()

NB.BazookaTowerPlaceholder = class BazookaTowerPlaceholder extends NB.BazookaTower
  constructor: (@coordinates) ->
    @direction = 's'
    @cost = 0
    @radius = data = NB.towerData.BazookaTower().upgrades.range[0].sq
    unless @coordinates
      @hovering = true
    @shouldDrawRange = true
  tick: -> # just don't shoot!
    # TODO: Memoize if possible
    x = @coordinates[0]
    y = @coordinates[1]
    @range = []
    for i in [1..@radius]
      @range.push(
        switch @direction
          when 'n' then [x, y-i]
          when 'e' then [x+i, y]
          when 's' then [x, y+i]
          when 'w' then [x-i, y]
      )
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
  drawUpgrades: -> # don't draw them
  promote: ->
    new NB.BazookaTower(@coordinates, @direction)
