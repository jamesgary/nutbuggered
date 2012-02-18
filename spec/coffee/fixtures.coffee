NB.TestCreep = class TestCreep extends NB.Creep
  constructor: (data) ->
    data = {
      type: NB.TestCreep,
      money: 10,
      hpMod: 2,
      speedMod: 3,
      countMod: 4,
      waitMod: 1,
      path: new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]]),
    }
    super(data)
  tick: ->
    @position = @path.travel(@position, @speed)
