NB.Creep = class Creep
  defaultHp: 50
  defaultSpeed: .01
  defaultWait: 200
  defaultCount: 10
  bitePower: 5

  constructor: (data) ->
    @parentWave = data.parentWave
    @path = data.path
    @position = @path.start()
    @traveled = 0

    @speed = @defaultSpeed * data.speedMod
    @hp = @maxHp = @defaultHp * data.hpMod
    @wait = @defaultWait * data.waitMod
  tick: ->
    newPosition = @path.travel(@position, @speed)
    @traveled += @speed
    if newPosition
      @position = newPosition
    else
      NB.Director.level.tree.damage(@bitePower)
  isInRange: (allCoordinates) ->
    for coordinates in allCoordinates
      posX = @position[0]
      posY = @position[1]
      coorX = coordinates[0]
      coorY = coordinates[1]
      if ((posX - .5 < coorX < posX + .5) &&
          (posY - .5 < coorY < posY + .5))
        return true
    false
  damage: (hp) ->
    @hp -= hp
    if @hp <= 0
      @die()
  isAlive: ->
    @health > 0
  die: ->
    @parentWave.notifyDeathOf(this)
