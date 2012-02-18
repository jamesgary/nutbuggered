describe 'Path', ->
  beforeEach ->
    @path = new NB.Path([
      [0, 0],
      [0, 10],
      [20,10],
      [20, 5],
      [15, 5],
    ])
  describe '#start', ->
    it 'returns the start coordinates', ->
      expect(@path.start()).toEqual [0,0]
  describe '#end', ->
    it 'returns the finish coordinates', ->
      expect(@path.finish()).toEqual [15,5]
  describe '#contains', ->
    it 'returns false for a cell it does not contain', ->
      expect(@path.contains([1,1])).toBeFalsy()
      expect(@path.contains([19,9])).toBeFalsy()
    it 'returns true for a cell it does contain', ->
      expect(@path.contains([0, 0])).toBeTruthy() # corner
      expect(@path.contains([0, 9])).toBeTruthy() # edge
      expect(@path.contains([0, 10])).toBeTruthy() # corner
      expect(@path.contains([19,10])).toBeTruthy() # edge
      expect(@path.contains([20,10])).toBeTruthy() # corner
      expect(@path.contains([20, 9])).toBeTruthy() # edge
      expect(@path.contains([20, 5])).toBeTruthy() # corner
      expect(@path.contains([16, 5])).toBeTruthy() # edge
      expect(@path.contains([15, 5])).toBeTruthy() # corner
  describe '#travel', ->
    describe 'when possible', ->
      beforeEach ->
        @origin = [0,0]
      it 'returns the coordinates from given origin traveled given distance', ->
        distance = 1
        expect(@path.travel(@origin, distance)).toEqual [0, 1]
      it 'returns the coordinates from given origin traveled a large given distance', ->
        distance = 12
        expect(@path.travel(@origin, distance)).toEqual [2, 10]
      it 'returns the coordinates from given origin traveled a huge given distance', ->
        distance = 39.9
        expect(@path.travel(@origin, distance)).toEqualAbout [15.1, 5]
    describe 'when not possible', ->
      beforeEach ->
        @origin = [0,0]
      it 'returns false', ->
        distance = 999
        expect(@path.travel(@origin, distance)).toBeFalsy()
  describe '#sortCoordinates', -> # obsolete?
    # note: breaks on corners
    it 'sorts coordinates from first to last', ->
      @coordinates = [[19,10], [10,10], [0,5], [0,0], [15,5], [16,5]]
      expect(@path.sortCoordinates(@coordinates)).toEqual(
        [[0,0], [0,5], [10,10], [19,10], [16,5], [15,5]]
      )
