describe 'Level', ->
  beforeEach ->
    @path = new NB.Path([[2,2],[6,2]])
    @waveData1 = {creepData: {type: NB.TestCreep, hpMod: 1, speedMod: 1, countMod: 1, waitMod: 1}}
    @waveData2 = {creepData: {type: NB.TestCreep, hpMod: 1.2, speedMod: 1.2, countMod: .8, waitMod: .8}}
    @waveData3 = {creepData: {type: NB.TestCreep, hpMod: 2.5, speedMod: 2.5, countMod: 2.5, waitMod: 1}}
    levelData = {path: @path, waves: [@waveData1, @waveData2, @waveData3]}
    @level = new NB.Level(levelData)
  it 'creates a list of waves', ->
    expect(@level.waves.length).toBe 3
    expect(@level.waves[0] instanceof NB.Wave).toBeTruthy
  describe '#sendNextWave', ->
    it 'sends a wave to be ticked', ->
      firstWave = @level.waves[0]
      spyOn(firstWave, 'tick')
      @level.sendNextWave()
      @level.tick()
      expect(firstWave.tick).toHaveBeenCalled()
  describe '#findCreep', ->
    it 'finds a creep in a range', ->
      # FIXME being lazy
      expect(@level.findCreep({range: [[2, 2]]}).length).toBe 0
      @level.sendNextWave()
      expect(@level.findCreep({range: [[2, 2]]}).length).toBe 1
      @level.sendNextWave()
      expect(@level.findCreep({range: [[2, 2]]}).length).toBe 2
    it 'finds the first/last/strongest/weakest creep'
    it 'finds a spread or not'

# Level.sendNextWave
#
# Level has many Waves
# Wave
#   list of Creep to appear at a given tick
#
# Level.load(level_data)
# Level.sendNextWave()
# - tells Director when player wins/loses
