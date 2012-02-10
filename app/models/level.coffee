NB.Level = class Level
  constructor: (data) ->
    @waves = for waveData in data.waves
      waveData.path = data.path
      new NB.Wave(waveData)
    @currentWaves = []
  sendNextWave: ->
    @currentWaves.push(@waves.shift())
  tick: ->
    wave.tick() for wave in @currentWaves
  findCreep: (criteria) ->
    #range = criteria.range
    (wave.findCreep(criteria) for wave in @currentWaves)
