describe 'Map', ->
  beforeEach ->
    @map = new NB.Map()
  it 'uses default values', ->
    expect(@map.height).toEqual 16
    expect(@map.width).toEqual 16
    expect(@map.path).toEqual new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]])
  it 'uses passed values', ->
    path = new NB.Path([[1,1],[1,13]])
    @map = new NB.Map({path: path})
    expect(@map.path).toEqual path
  it 'can retrieve cells', ->
    expect(@map.cellAt(1, 1)).toBe null
  describe 'when placing towers', ->
    beforeEach ->
      @tower = new NB.Tower()
      @coordinates = [2,3]
    it 'can have towers placed in empty cells', ->
      expect(@map.placeTower(@tower, @coordinates)).toBe true
      expect(@map.cellAt(2, 3)).toBe @tower
    it 'cannot have towers placed in occupied cells', ->
      @map.placeTower(@tower, @coordinates)
      tower2 = new NB.Tower()
      expect(@map.placeTower(tower2, @coordinates)).toBe false
      expect(@map.cellAt(2, 3)).toBe @tower
    it 'redraws the map', ->
      spyOn(@map, 'drawInit')
      @map.placeTower(@tower, @coordinates)
      expect(@map.drawInit).toHaveBeenCalled()
    xit 'cannot have towers placed on path'
    describe '#tick', ->
      it 'ticks all towers', ->
        spyOn(@tower, 'tick')
        @map.placeTower(@tower, [2,3])
        @map.tick()
        expect(@tower.tick).toHaveBeenCalled()
