describe 'Level', ->
  beforeEach ->
    @map = {
      path: {},
      placeTower: ->,
      tick: ->,
    }
    @treeHp = 1000
    @waveData1 = {}
    @waveData2 = {}
    @wavesData = [@waveData1, @waveData2]
    @levelData = {map: @map, wavesData: @wavesData, tree: @tree}

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
  describe '#checkForVictory', ->
    beforeEach ->
      @level = new NB.Level(@levelData)
      @deadWave = {isAlive: -> false}
      @liveWave = {isAlive: -> true}
    describe 'when some waves are not yet sent', ->
      beforeEach ->
        @level.waves = [new NB.Wave()]
      it 'returns false', ->
        expect(@level.checkForVictory()).toBeFalsy()
    describe 'when all waves have been sent', ->
      beforeEach ->
        @level.waves = []
      describe 'when all current waves are dead', ->
        beforeEach ->
          @level.currentWaves = [@deadWave, @deadWave]
        it 'returns true', ->
          expect(@level.checkForVictory()).toBeTruthy()
      describe 'when not all current waves are dead', ->
        beforeEach ->
          @level.currentWaves = [@deadWave, @liveWave]
        it 'returns false', ->
          expect(@level.checkForVictory()).toBeFalsy()
  it 'has a tree', ->
    @level = new NB.Level(@levelData)
    expect(@level.tree).toBe @tree
  describe '#notifyCompletionOf', ->
    beforeEach ->
      @level = new NB.Level(@levelData)
      spyOn(NB.Director, 'endGame')
      @wave = {}
      @level.currentWaves = [@wave]
    it 'removes the wave', ->
      @level.notifyCompletionOf(@wave)
      expect(@level.currentWaves).toEqual([])
    describe 'when all waves are completed', ->
      beforeEach ->
        @level.waves = []
        @level.currentWaves = [@wave]
      it 'ends the game victoriously', ->
        @level.notifyCompletionOf(@wave)
        expect(NB.Director.endGame).toHaveBeenCalledWith(true)
    describe 'when some waves are still queued', ->
      beforeEach ->
        @level.waves = [{}]
        @level.currentWaves = [@wave]
      it 'does not end the game', ->
        @level.notifyCompletionOf(@wave)
        expect(NB.Director.endGame).not.toHaveBeenCalled()
    describe 'when some waves are still running', ->
      beforeEach ->
        @level.waves = []
        @level.currentWaves = [@wave, @wave]
      it 'does not end the game', ->
        @level.notifyCompletionOf(@wave)
        expect(NB.Director.endGame).not.toHaveBeenCalled()
