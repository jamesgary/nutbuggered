NB.Level = class Level
  constructor: (data) ->
    @waves = (new NB.Wave(waveData) for waveData in data.waves)
    @currentWaves = []
  sendNextWave: ->
    @currentWaves.push(@waves.shift())
  tick: ->
    wave.tick() for wave in @currentWaves
