NB.Creep = class Creep
  defaultHp: 150
  defaultSpeed: .02
  defaultWait: 120
  defaultCount: 10
  bitePower: .2

  constructor: (data) ->
    @parentWave = data.parentWave
    @path = data.path
    @position = @path.start()
    @traveled = 0

    @slowMod = 1
    @speed = @defaultSpeed * data.speedMod
    @hp = @maxHp = @defaultHp * data.hpMod
    @wait = @defaultWait * data.waitMod
    @money = data.money
  tick: ->
    speed = @speed * @slowMod
    newPosition = @path.travel(@position, speed)
    @traveled += speed
    if newPosition
      @position = newPosition
    else
      NB.Director.level.tree.damage(@bitePower)
    @slowMod = 1 # reset
  isInRange: (coordinate) ->
    posX = @position[0]
    posY = @position[1]
    coorX = coordinate[0]
    coorY = coordinate[1]
    (
      (posX - .5 < coorX < posX + .5) &&
      (posY - .5 < coorY < posY + .5)
    )
  damage: (hp) ->
    @hp -= hp
    if @hp <= 0
      @die()
  isAlive: ->
    @health > 0
  die: ->
    NB.Director.level.grantMoney(@money)
    @parentWave.notifyDeathOf(this)
  slow: (percent) ->
    @slowMod = 1 - percent
