NB.Map = class Map
  constructor: (data = {}) ->
    @height = 16 # TODO
    @width  = 16 # TODO
    @path = if data.path? then data.path else new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]]) # TODO
    @cells = []
    for x in [0...@width]
      @cells[x] = []
      for y in [0...@width]
        @cells[x][y] = null
    @towers = []
  placeTower: (tower, coordinates) ->
    x = coordinates[0]
    y = coordinates[1]
    if @cells[x][y] == null #isEmpty
      @cells[x][y] = tower
      @towers.push(tower)
      @drawInit()
      true
    else
      false
  cellAt: (x, y) ->
    @cells[x][y]
  tick: ->
    tower.tick() for tower in @towers
