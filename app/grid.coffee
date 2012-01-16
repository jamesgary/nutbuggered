(exports ? this).Grid = class Grid
  constructor: (@width = 10, @length = 10) ->
    @cells = []
    for x in [0...@length]
      @cells[x] = []
      @cells[x][y] = false for y in [0...@width]
  generate: ->
    newCells = []
    for x in [0...@length]
      newCells[x] = []
      for y in [0...@width]
        count = @getNeighborCount(x,y)
        newCell = @shouldLive(@cellAt(x,y), count)
        newCells[x][y] = newCell
    @cells = newCells
  cellAt: (x, y) ->
    return false if (x < 0 || y < 0) || (x >= @length || y >= @width)
    @cells[x][y]
  randomize: ->
    for x in [0...@length]
      for y in [0...@width]
        @cells[x][y] = Math.random() > .5
  # private
  getNeighborCount: (x, y) ->
    count = 0
    count += @cellAt(x - 1, y - 1)
    count += @cellAt(x,     y - 1)
    count += @cellAt(x + 1, y - 1)
    count += @cellAt(x - 1, y)
    count += @cellAt(x + 1, y)
    count += @cellAt(x - 1, y + 1)
    count += @cellAt(x,     y + 1)
    count += @cellAt(x + 1, y + 1)
    count
  shouldLive: (isLiving, neighborCount) ->
    if isLiving
      if neighborCount < 2
        newCell = false
      else if neighborCount == 2 || neighborCount == 3
        newCell = true
      else # count > 3
        newCell = false
    else
      if neighborCount == 3
        newCell = true
      else
        newCell = false
    newCell
