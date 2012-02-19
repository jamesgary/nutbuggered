describe 'Level', ->
  beforeEach ->
    @map = {
      path: {}
      placeTower: ->
      canPlaceTower: ->
      tick: ->
      removeTower: ->
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
      boostIncubatingCreepsMoney: ->
    }
    spyOn(NB, 'Wave').andReturn(@mockWave)
  describe '#tick', ->
    it 'makes the map tick', ->
      spyOn(@map, 'tick')
      @level = new NB.Level(@levelData)
      @level.tick()
      expect(@map.tick).toHaveBeenCalled()
  describe '#sendNextWave', ->
    it 'returns true if a wave could be sent', ->
      @level = new NB.Level(@levelData)
      expect(@level.sendNextWave()).toBeTruthy()
      expect(@level.sendNextWave()).toBeTruthy()
    it 'returns false if no more waves', ->
      @level = new NB.Level(@levelData)
      @level.sendNextWave()
      @level.sendNextWave()
      expect(@level.sendNextWave()).toBeFalsy()
    it 'boosts the money granted by all incubating creeps in the current wave', ->
      @level = new NB.Level(@levelData)
      @level.currentWaves = [@mockWave]
      spyOn(@mockWave, 'boostIncubatingCreepsMoney')
      @level.sendNextWave()
      expect(@mockWave.boostIncubatingCreepsMoney).toHaveBeenCalled()

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
    beforeEach ->
      @firstRange = {}
      @nextRange = {}
      @emptyRange = {}
      self = this

      creeps = []
      creeps.push(@creepInFirstRange1 = {isInRange: {}, traveled: 0, hp: 100, z: 'creepInFirstRange1'})
      creeps.push(@creepInFirstRange2 = {isInRange: {}, traveled: 0, hp: 100, z: 'creepInFirstRange2'})
      creeps.push(@creepInNextRange1  = {isInRange: {}, traveled: 0, hp: 100, z: 'creepInNextRange1'})
      creeps.push(@creepInNextRange2  = {isInRange: {}, traveled: 0, hp: 100, z: 'creepInNextRange2'})
      creeps.push(@creepOutOfRange    = {isInRange: {}, traveled: 0, hp: 100, z: 'creepOutOfRange'})
      spyOn(@creepInFirstRange1, 'isInRange').andCallFake((r) -> r == self.firstRange)
      spyOn(@creepInFirstRange2, 'isInRange').andCallFake((r) -> r == self.firstRange)
      spyOn(@creepInNextRange1,  'isInRange').andCallFake((r) -> r == self.nextRange)
      spyOn(@creepInNextRange2,  'isInRange').andCallFake((r) -> r == self.nextRange)
      spyOn(@creepOutOfRange,    'isInRange').andReturn(false)

      @level = new NB.Level(@levelData)
      spyOn(@level, 'getAllCreep').andReturn(creeps)
    describe 'without any limit', ->
      it 'finds no creep when there is none', ->
        expect(@level.findCreep(range: @emptyRange)).toEqual []
      it 'finds creep when there is some', ->
        foundCreeps = @level.findCreep(range: [@firstRange, @nextRange])
        expect(foundCreeps).toContain @creepInFirstRange1
        expect(foundCreeps).toContain @creepInFirstRange2
        expect(foundCreeps).toContain @creepInNextRange1
        expect(foundCreeps).toContain @creepInNextRange2
        expect(foundCreeps.length).toBe 4
    describe 'with an overall limit', ->
      describe 'with a priority of first', ->
        it 'finds the first creeps', ->
          @creepInFirstRange1.traveled = 5
          @creepInNextRange1.traveled = 5
          @creepInNextRange2.traveled = 5
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limit: 3, priority: NB.Priorities.FIRST
          )
          expect(foundCreeps).toContain(@creepInFirstRange1)
          expect(foundCreeps).toContain(@creepInNextRange1)
          expect(foundCreeps).toContain(@creepInNextRange2)
          expect(foundCreeps.length).toBe 3
      describe 'with a priority of last', ->
        it 'finds the first creeps', ->
          @creepInFirstRange1.traveled = 5
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limit: 3, priority: NB.Priorities.LAST
          )
          expect(foundCreeps).toContain(@creepInFirstRange2)
          expect(foundCreeps).toContain(@creepInNextRange1)
          expect(foundCreeps).toContain(@creepInNextRange2)
          expect(foundCreeps.length).toBe 3
      describe 'with a priority of strongest', ->
        it 'finds the strongest creeps', ->
          @creepInNextRange2.hp = 10
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limit: 3, priority: NB.Priorities.STRONGEST
          )
          expect(foundCreeps).toContain(@creepInFirstRange1)
          expect(foundCreeps).toContain(@creepInFirstRange2)
          expect(foundCreeps).toContain(@creepInNextRange1)
          expect(foundCreeps.length).toBe 3
      describe 'with a priority of weak', ->
        it 'finds the weakest creeps', ->
          @creepInFirstRange1.hp = 10
          @creepInFirstRange2.hp = 10
          @creepInNextRange2.hp = 10
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limit: 3, priority: NB.Priorities.WEAKEST
          )
          expect(foundCreeps).toContain(@creepInFirstRange1)
          expect(foundCreeps).toContain(@creepInFirstRange2)
          expect(foundCreeps).toContain(@creepInNextRange2)
          expect(foundCreeps.length).toBe 3
    describe 'with a limit per range', ->
      describe 'with a priority of first', ->
        it 'finds the first creeps', ->
          @creepInFirstRange1.traveled = 5
          @creepInNextRange2.traveled = 5
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limitPerRange: 1, priority: NB.Priorities.FIRST
          )
          expect(foundCreeps).toContain(@creepInFirstRange1)
          expect(foundCreeps).toContain(@creepInNextRange2)
          expect(foundCreeps.length).toBe 2
      describe 'with a priority of last', ->
        it 'finds the first creeps', ->
          @creepInFirstRange1.traveled = 5
          @creepInNextRange2.traveled = 5
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limitPerRange: 1, priority: NB.Priorities.LAST
          )
          expect(foundCreeps).toContain(@creepInFirstRange2)
          expect(foundCreeps).toContain(@creepInNextRange1)
          expect(foundCreeps.length).toBe 2
      describe 'with a priority of strongest', ->
        it 'finds the strongest creeps', ->
          @creepInFirstRange1.hp = 1000
          @creepInNextRange2.hp = 1000
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limitPerRange: 1, priority: NB.Priorities.STRONGEST
          )
          expect(foundCreeps).toContain(@creepInFirstRange1)
          expect(foundCreeps).toContain(@creepInNextRange2)
          expect(foundCreeps.length).toBe 2
      describe 'with a priority of weakest', ->
        it 'finds the weakest creeps', ->
          @creepInFirstRange1.hp = 1
          @creepInNextRange2.hp = 1
          foundCreeps = @level.findCreep(
            range: [@firstRange, @nextRange], limitPerRange: 1, priority: NB.Priorities.WEAKEST
          )
          expect(foundCreeps).toContain(@creepInFirstRange1)
          expect(foundCreeps).toContain(@creepInNextRange2)
          expect(foundCreeps.length).toBe 2

  describe '#placeTower', ->
    beforeEach ->
      @level = new NB.Level(@levelData)
      @tower = {cost: 25}
      @coordinates = [2, 3]
      spyOn(@level.map, 'placeTower')
    it 'places a tower on the map', ->
      @level.placeTower(@tower, @coordinates)
      expect(@level.map.placeTower).toHaveBeenCalledWith(@tower, [2, 3])
    it 'charges the player the cost', ->
      @level.money = 500
      @level.placeTower(@tower, @coordinates)
      expect(@level.money).toEqual 475
  describe '#canPlaceTower', ->
    beforeEach ->
      @mockTower = 'mockTower'
      @coordinates = [2, 3]
      @level = new NB.Level(@levelData)
    describe 'if map can place tower', ->
      beforeEach ->
        spyOn(@level.map, 'canPlaceTower').andReturn(true)
      it 'returns true if map can place tower', ->
        expect(@level.canPlaceTower(@tower, @coordinates)).toBeTruthy()
    describe 'if map cannot place tower', ->
      beforeEach ->
        spyOn(@level.map, 'canPlaceTower').andReturn(false)
      it 'returns true if map can place tower', ->
        expect(@level.canPlaceTower(@tower, @coordinates)).toBeFalsy()
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
  describe '#removeTower', ->
    it 'removes the given tower from the map', ->
      @level = new NB.Level(@levelData)
      tower = {}
      spyOn(@level.map, 'removeTower')
      @level.removeTower(tower)
      expect(@level.map.removeTower).toHaveBeenCalledWith(tower)
