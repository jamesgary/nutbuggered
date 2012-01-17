describe 'Map', ->
  beforeEach ->
    @map = new NB.Map
  it 'exists', ->
    expect(@map).toNotBe undefined
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
