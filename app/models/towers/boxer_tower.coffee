NB.BoxerTower = class BoxerTower extends NB.Tower
  constructor: (@coordinates, @direction) ->
    data = NB.towerData.BoxerTower()
    super(data)
    x = @coordinates[0]
    y = @coordinates[1]
    @range = [
      switch @direction
        when 'n' then [x, y-1]
        when 'e' then [x+1, y]
        when 's' then [x, y+1]
        when 'w' then [x-1, y]
    ]
  attack: ->
    creeps = NB.Director.level.findCreep(
      range: @range
      limitPerRange: 1
      priority: @priority
    )
    creep.damage(@power) for creep in creeps
    attacked = creeps.length > 0
    if attacked
      @drawAttack()
    return attacked

  canUpgradeRange: -> false
  upgradeSpecial: ->
    x = @coordinates[0]
    y = @coordinates[1]
    if @upgrades.special.length == 2 # first upgrade
      @range.push(
        switch @direction
          when 'n' then [x, y+1]
          when 'e' then [x-1, y]
          when 's' then [x, y-1]
          when 'w' then [x+1, y]
      )
    else
      ranges = [
        [x-1,y+1],[x,y+1],[x+1,y+1]
        [x-1,y  ],        [x+1,y  ]
        [x-1,y-1],[x,y-1],[x+1,y-1]
      ]
      @range = ranges
    @upgrades.special.shift()

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
  drawUpgrades: -> # don't draw them
  promote: ->
    new NB.BoxerTower(@coordinates, @direction)
