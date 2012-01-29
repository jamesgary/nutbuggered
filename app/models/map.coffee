NB.Map = class Map
  constructor: ->
    @height = 15 # TODO
    @width  = 15 # TODO
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
