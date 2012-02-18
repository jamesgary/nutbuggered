NB.Arc = class Arc
  constructor: (coordinate1, coordinate2) ->
    @start = coordinate1
    @finish = coordinate2
    if @isHorizontal = @start[1] == @finish[1]
      @direction = if @start[0] < @finish[0] then 1 else -1
    else
      @direction = if @start[1] < @finish[1] then 1 else -1
  contains: (coordinate) ->
    return true if ((coordinate[0] == @start[0]  && coordinate[1] == @start[1]) ||
                    (coordinate[0] == @finish[0] && coordinate[1] == @finish[1]))
    if @isHorizontal
      return coordinate[1] == @start[1] && ((coordinate[0] >= @start[0]) == (coordinate[0] <= @finish[0]))
    else
      return coordinate[0] == @start[0] && ((coordinate[1] >= @start[1]) == (coordinate[1] <= @finish[1]))
  travel: (coordinate, distance) ->
    distance *= @direction
    if @isHorizontal
      coordinate = [coordinate[0] + distance, coordinate[1]]
    else
      coordinate = [coordinate[0], coordinate[1] + distance]
    if @contains(coordinate)
      return coordinate
    else #calculate distance
      if @isHorizontal
        diff = coordinate[0] - @finish[0]
      else
        diff = coordinate[1] - @finish[1]
      return Math.abs(diff)
  distanceTraveledFor: (coordinate) -> # obsolete?
    if @isHorizontal
      (coordinate[0] - @start[0]) * @direction
    else
      (coordinate[1] - @start[1]) * @direction
