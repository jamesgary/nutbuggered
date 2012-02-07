NB.Wave.prototype.draw = (ctx) ->
  creep.draw(ctx) for creep in @liveCreeps
