NB.Creep = class Creep
  defaultHp: 50
  defaultSpeed: .01
  defaultWait: 200
  defaultCount: 10

  constructor: (data) ->
    @path = NB.currentMap.path
    @position = @path.start()

    @speed = @defaultSpeed * data.speedMod
    @hp = @defaultHp * data.hpMod
    @wait = @defaultWait * data.waitMod
  tick: ->
    @position = @path.travel(@position, @speed)
