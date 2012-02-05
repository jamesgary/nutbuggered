NB.Map = class Map
  constructor: (data) ->
    @height = 15 # TODO
    @width  = 15 # TODO
    @path = new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]])
    @cells = []
    for x in [0...@width]
      @cells[x] = []
      for y in [0...@width]
        @cells[x][y] = null
  placeTower: (tower, x, y) ->
    if @cells[x][y] == null #isEmpty
      @cells[x][y] = tower
      true
    else
      false
  cellAt: (x, y) ->
    @cells[x][y]
