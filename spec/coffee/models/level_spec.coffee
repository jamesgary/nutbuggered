describe 'Level', ->
  beforeEach ->
    @map = {
      path: {},
      placeTower: ->,
      tick: ->,
    }
    @waveData1 = {}
    @waveData2 = {}
    @wavesData = [@waveData1, @waveData2]
    @levelData = {map: @map, wavesData: @wavesData}

    @mockWave = {
      tick: ->
      draw: ->
      findCreep: ->
    }
    spyOn(NB, 'Wave').andReturn(@mockWave)
  describe '#tick', ->
    it 'makes the map tick', ->
      spyOn(@map, 'tick')
      @level = new NB.Level(@levelData)
      @level.tick()
      expect(@map.tick).toHaveBeenCalled()
  describe '#sendNextWave & #tick', ->
    it 'makes the next wave tick when level is ticked', ->
      spyOn(@mockWave, 'tick')
      @level = new NB.Level(@levelData)
      expect(NB.Wave).toHaveBeenCalledWith(@waveData1)
      @level.tick()
      expect(@mockWave.tick).not.toHaveBeenCalled()
      @level.sendNextWave()
      expect(@mockWave.tick).not.toHaveBeenCalled()
      @level.tick()
      expect(@mockWave.tick).toHaveBeenCalled()
  describe '#findCreep', ->
    describe 'with one current wave', ->
      beforeEach ->
        @level = new NB.Level(@levelData)
        @level.sendNextWave()
      it 'finds a creep in the current wave with a criteria', ->
        @mockCreep = {}
        spyOn(@mockWave, 'findCreep').andReturn(@mockCreep)
        criteria = {}
        @level.findCreep(criteria)
        expect(@mockWave.findCreep).toHaveBeenCalledWith(criteria)
    it 'finds the first/last/strongest/weakest creep'
    it 'finds a spread or not'
  describe '#placeTower', ->
    beforeEach ->
      @level = new NB.Level(@levelData)
    it 'places a tower on the map', ->
      tower = 'mockTower'
      coordinates = [2, 3]
      spyOn(@level.map, 'placeTower')

      @level.placeTower(tower, coordinates)
      expect(@level.map.placeTower).toHaveBeenCalledWith(tower, [2, 3])
