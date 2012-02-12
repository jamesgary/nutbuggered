NB.Tree = class Tree
  constructor: (@hp) ->

  damage: (hp) ->
    @hp -= hp
    if @hp <= 0
      NB.Director.endGame(false)
