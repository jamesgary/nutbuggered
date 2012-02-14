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
    if @canPlaceTower(tower, coordinates)
      @cells[x][y] = tower
      @towers.push(tower)
      @drawInit()
      true
    else
      false
  canPlaceTower: (tower, coordinates) ->
    x = coordinates[0]
    y = coordinates[1]
    cellOccupant = @cells[x][y]
    (@cells[x][y] == null || cellOccupant == tower) && !@path.contains([x,y])
  cellAt: (x, y) ->
    @cells[x][y]
  tick: ->
    tower.tick() for tower in @towers
  removeTower: (tower) ->
    coordinates = tower.coordinates
    x = coordinates[0]
    y = coordinates[1]
    @cells[x][y] = null
    @towers.remove(tower)
