NB.Tree = class Tree
  constructor: (@hp, coordinates) ->
    @maxHp = @hp
    @x = (coordinates[0] * 32) - 80 + (32/2)
    @y = (coordinates[1] * 32) - 80 + (32/2)

  damage: (hp) ->
    @hp -= hp
    if @hp <= 0
      NB.Director.endGame(false)
  healthPercentage: ->
    @hp / @maxHp
