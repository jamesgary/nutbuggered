describe 'Wave', ->
  beforeEach ->
    waveData = {
      creepData: {
        type: NB.TestCreep,
        hpMod: 1,
        speedMod: 1,
        countMod: 1,
        waitMod: 1,
      },
      path: new NB.Path([[1, 2], [1, 6]])
    }
    @wave = new NB.Wave(waveData)
  describe '#tick', ->
    it 'loads a creep if enough time elapsed', ->
      @wave.tick()
      expect(@wave.liveCreeps.length).toBe 1
      @wave.tick()
      expect(@wave.liveCreeps.length).toBe 1 # don't load more
      # DO load after 20 times
      @wave.tick() for i in [1..10]
      expect(@wave.liveCreeps.length).toBe 2 # don't load more
  describe '#findCreep', ->
    it 'finds no creep when there is none', ->
      creeps = @wave.findCreep({range: [[1, 2]]})
      expect(creeps).toEqual []
    it 'finds a creep when there is one', ->
      @wave.tick()
      creeps = @wave.findCreep({range: [[1, 2]]})
      expect(creeps[0]).toEqual @wave.liveCreeps[0]
    xit 'finds the first/last/strongest/weakest creep'
    xit 'finds a spread or not'
