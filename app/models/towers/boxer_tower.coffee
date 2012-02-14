NB.BoxerTower = class BoxerTower extends NB.Tower
  constructor: (@coordinates, @direction) ->
    @cost = 50
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

NB.BoxerTowerPlaceholder = class BoxerTowerPlaceholder extends NB.BoxerTower
  constructor: (@coordinates) ->
    unless @coordinates
      @hovering = true
  tick: -> # don't shoot!
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
