NB.Creep = class Creep
  constructor: (path) ->
    @path = path
    @position = path.start()
    @speed = .001
  tick: ->
    @position = @path.travel(@position, @speed)
