describe 'Wave', ->
  beforeEach ->
    @mockCreep = {
      defaultCount: 42,
      tick: ->,
      isInRange: ->,
      isAlive: -> true,
      money: 100,
    }
    spyOn(NB, 'TestCreep').andReturn(@mockCreep)
    @path = {}
    @waveData = {
      creepData: {
        type: NB.TestCreep,
        hpMod: 2,
        speedMod: 3,
        countMod: 4,
        waitMod: 5,
      },
      path: @path,
    }
    @wave = new NB.Wave(@waveData)
  describe '.constructor', ->
    it 'spawns all creep up front', ->
      numCreepToSpawn = (4 * 42) + 1 # (one more for the mold)
      expect(NB.TestCreep.callCount).toBe numCreepToSpawn
  describe '#tick', ->
    it 'spawns and ticks the first creep', ->
      spyOn(@mockCreep, 'tick')
      @wave.tick()
      expect(@mockCreep.tick).toHaveBeenCalled()
    xit 'spawns and ticks more creep'
    # it 'loads a creep if enough time elapsed', ->
    #   @wave.tick()
    #   expect(@wave.liveCreeps.length).toBe 1
    #   @wave.tick()
    #   expect(@wave.liveCreeps.length).toBe 1 # don't load more
    #   # DO load after 20 times
    #   @wave.tick() for i in [1..10]
    #   expect(@wave.liveCreeps.length).toBe 2 # don't load more
  describe '#isAlive', ->
    describe 'when not all creeps have been sent', ->
      beforeEach ->
        @wave.incubatingCreeps = [@mockCreep]
      it 'returns true', ->
        expect(@wave.isAlive()).toBeTruthy()
    describe 'when all creeps have been sent', ->
      beforeEach ->
        @wave.incubatingCreeps = []
      describe 'when there are some live creep', ->
        beforeEach ->
          @wave.liveCreeps = [@mockCreep]
        it 'returns true', ->
          expect(@wave.isAlive()).toBeTruthy()
      describe 'when there are no more live creep', ->
        beforeEach ->
          @wave.liveCreeps = []
      it 'returns true', ->
        expect(@wave.isAlive()).toBeFalsy()
  describe '#notifyDeathOf', ->
    it 'removes the dead creep', ->
      @wave.liveCreeps = [@mockCreep]
      @wave.notifyDeathOf(@mockCreep)
      expect(@wave.liveCreeps).not.toContain(@mockCreep)
    describe 'which was not the last creep of the wave', ->
      it 'notifies the level that this wave is cleared', ->
        NB.Director.level = {notifyCompletionOf: ->}
        spyOn(NB.Director.level, 'notifyCompletionOf')
        @wave.incubatingCreeps = []
        @wave.liveCreeps = [@mockCreep, @mockCreep]
        @wave.notifyDeathOf(@mockCreep)
        expect(NB.Director.level.notifyCompletionOf).not.toHaveBeenCalledWith(@wave)
    describe 'which was the last creep of the wave', ->
      it 'notifies the level that this wave is cleared', ->
        NB.Director.level = {notifyCompletionOf: ->}
        spyOn(NB.Director.level, 'notifyCompletionOf')
        @wave.incubatingCreeps = []
        @wave.liveCreeps = [@mockCreep]
        @wave.notifyDeathOf(@mockCreep)
        expect(NB.Director.level.notifyCompletionOf).toHaveBeenCalledWith(@wave)
  describe '#boostIncubatingCreepsMoney', ->
    it 'increases the money for all incubating creeps', ->
      @wave.incubatingCreeps = [@mockCreep]
      @wave.boostIncubatingCreepsMoney()
      expect(@mockCreep.money).toEqual 120

