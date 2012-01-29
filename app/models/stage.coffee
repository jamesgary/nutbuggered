NB.Stage = class Stage
  constructor: ->
    @tickables = []
    @drawables = []
  load: (obj) ->
    @tickables.push obj if obj.tick
    @drawables.push obj if obj.draw
  tick: ->
    tickable.tick() for tickable in @tickables
  draw: ->
    drawable.draw() for drawable in @drawables
