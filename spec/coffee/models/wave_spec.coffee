describe 'Wave', ->
  beforeEach ->
    waveData = { creepData: {
      type: NB.TestCreep,
      hpMod: 1,
      speedMod: 1,
      countMod: 1,
      waitMod: 1,
    }}
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
