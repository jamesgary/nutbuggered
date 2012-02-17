#describe 'Map', ->
#  beforeEach ->
#    @map = new NB.Map()
#  it 'uses default values', ->
#    expect(@map.height).toEqual 16
#    expect(@map.width).toEqual 16
#    expect(@map.path).toEqual new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]])
#  it 'uses passed values', ->
#    path = new NB.Path([[1,1],[1,13]])
#    @map = new NB.Map({path: path})
#    expect(@map.path).toEqual path
#  it 'can retrieve cells', ->
#    expect(@map.cellAt(1, 1)).toBe null
#  describe 'when placing towers', ->
#    beforeEach ->
#      @tower = new NB.Tower()
#      @coordinates = [2,3]
#    it 'places towers when possible', ->
#      expect(@map.placeTower(@tower, @coordinates)).toBe true
#      expect(@map.cellAt(2, 3)).toBe @tower
#    it 'does not place towers when impossible', ->
#      spyOn(@map, 'canPlaceTower').andReturn(false)
#      expect(@map.placeTower(@tower, @coordinates)).toBe false
#      expect(@map.cellAt(2, 3)).toBe null
#    it 'redraws the map', ->
#      spyOn(@map, 'drawInit')
#      @map.placeTower(@tower, @coordinates)
#      expect(@map.drawInit).toHaveBeenCalled()
#    describe '#tick', ->
#      it 'ticks all towers', ->
#        spyOn(@tower, 'tick')
#        @map.placeTower(@tower, [2,3])
#        @map.tick()
#        expect(@tower.tick).toHaveBeenCalled()
#  describe '#canPlaceTower', ->
#    beforeEach ->
#      @tower = new NB.Tower()
#      @coordinates = [2,3]
#    it 'can have towers placed in empty cells', ->
#      expect(@map.canPlaceTower(@tower, @coordinates)).toBeTruthy()
#    it 'can have towers placed in cells occupied by itself (needed for placeholding)', ->
#      #@tower.hovering = true
#      @map.placeTower(@tower, @coordinates)
#      expect(@map.canPlaceTower(@tower, @coordinates)).toBeTruthy()
#    it 'cannot have towers placed in cells occupied by others', ->
#      @map.placeTower(new NB.Tower(), @coordinates)
#      expect(@map.canPlaceTower(@tower, @coordinates)).toBeFalsy()
#    it 'cannot have towers placed on path', ->
#      expect(@map.canPlaceTower(@tower, [7,7])).toBeFalsy()
#  describe 'removeTower', ->
#    beforeEach ->
#      @tower = {coordinates: [2,3]}
#      @map.towers = [@tower]
#      @map.removeTower(@tower)
#    it 'should remove the given tower from the list of towers', ->
#      expect(@map.towers).toEqual []
#    it 'should remove the given tower from the map cells', ->
#      expect(@map.cells[2][3]).toEqual null
