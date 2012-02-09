describe 'Map', ->
  beforeEach ->
    @map = new NB.Map()
  it 'uses default values', ->
    expect(@map.height).toEqual 15
    expect(@map.width).toEqual 15
    expect(@map.path).toEqual new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]])
  it 'uses passed values', ->
    path = new NB.Path([[1,1],[1,13]])
    @map = new NB.Map({path: path})
    expect(@map.path).toEqual path
  it 'can retrieve cells', ->
    expect(@map.cellAt(1, 1)).toBe null
  describe 'when placing towers', ->
    beforeEach ->
      @tower = new NB.Tower
    it 'can have towers placed in empty cells', ->
      expect(@map.placeTower(@tower, 1, 1)).toBe true
      expect(@map.cellAt(1, 1)).toBe @tower
    it 'cannot have towers placed in occupied cells', ->
      @map.placeTower(@tower, 1, 1)
      tower2 = new NB.Tower
      expect(@map.placeTower(tower2, 1, 1)).toBe false
      expect(@map.cellAt(1, 1)).toBe @tower
    it 'redraws the map', ->
      spyOn(@map, 'drawInit')
      @map.placeTower(@tower, 1, 1)
      expect(@map.drawInit).toHaveBeenCalled()
    xit 'cannot have towers placed on path'
