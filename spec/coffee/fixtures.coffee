NB.TestCreep = class TestCreep extends NB.Creep
  defaultHp: 1000
  defaultCount: 100
  defaultWait: 10
  defaultSpeed: .1

  constructor: (data) ->
    @path = data.path
    @position = @path.start()

    @speed = @defaultSpeed * data.speedMod
    @hp = @defaultHp * data.hpMod
    @wait = @defaultWait * data.waitMod
  tick: ->
    @position = @path.travel(@position, @speed)
