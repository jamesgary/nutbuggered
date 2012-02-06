describe 'Level', ->
  beforeEach ->
    @waveData1 = {creepData: {type: NB.TestCreep, hpMod: 1, speedMod: 1, countMod: 1, waitMod: 1}}
    @waveData2 = {creepData: {type: NB.TestCreep, hpMod: 1.2, speedMod: 1.2, countMod: .8, waitMod: .8}}
    @waveData3 = {creepData: {type: NB.TestCreep, hpMod: 2.5, speedMod: 2.5, countMod: 2.5, waitMod: 1}}
    levelData = {waves: [@waveData1, @waveData2, @waveData3]}
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





# Level.sendNextWave
#
# Level has many Waves
# Wave
#   list of Creep to appear at a given tick
#
# Level.load(level_data)
# Level.sendNextWave()
# - tells Director when player wins/loses
