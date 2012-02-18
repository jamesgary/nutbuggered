NB.Path = class Path
  constructor: (coordinates) ->
    @coordinates = coordinates
    @arcs = for i in [0...@coordinates.length - 1]
      new NB.Arc(@coordinates[i], @coordinates[i + 1])
  start: ->
    @coordinates[0]
  finish: ->
    @coordinates[@coordinates.length - 1]
  travel: (origin, distance) ->
    for i in [0...@arcs.length]
      arc = @arcs[i]
      if arc.contains(origin)
        result = arc.travel(origin, distance)
        break
    while(typeof result == 'number') # we've surpassed this arc's finish
      i++
      arc = @arcs[i]
      return false unless arc
      result = arc.travel(arc.start, result)
    result
  contains: (coordinate) ->
    for i in [0...@arcs.length]
      return true if @arcs[i].contains(coordinate)
    return false

  sortCoordinates: (coordinates) -> # obsolete?
    sortedCoordinates = []
    for arc in @arcs
      arcCoordinates = []
      for c in coordinates
        arcCoordinates.push(c) if arc.contains(c)
      sortByDistance = (a,b) ->
        arc.distanceTraveledFor(a) > arc.distanceTraveledFor(b)
      arcCoordinates.sort(sortByDistance)
      sortedCoordinates = sortedCoordinates.concat(arcCoordinates)
    sortedCoordinates
