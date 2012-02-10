NB.Creep = class Creep
  defaultHp: 50
  defaultSpeed: .01
  defaultWait: 200
  defaultCount: 10

  constructor: (data) ->
    @path = data.path
    @position = @path.start()

    @speed = @defaultSpeed * data.speedMod
    @hp = @defaultHp * data.hpMod
    @wait = @defaultWait * data.waitMod
  tick: ->
    @position = @path.travel(@position, @speed)
  isInRange: (coordinates) ->
    coordinates = coordinates[0] # FIXME
    posX = @position[0]
    posY = @position[1]
    coorX = coordinates[0]
    coorY = coordinates[1]
    ((posX - .5 < coorX < posX + .5) &&
     (posY - .5 < coorY < posY + .5))
  damage: (hp) ->
    @hp -= hp
