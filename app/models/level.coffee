NB.Level = class Level
  constructor: (data) ->
    @waves = for waveData in data.wavesData
      waveData.path = data.map.path
      new NB.Wave(waveData)
    @currentWaves = []
    @map = data.map
  sendNextWave: ->
    @currentWaves.push(@waves.shift())
  tick: ->
    wave.tick() for wave in @currentWaves
    @map.tick()
  findCreep: (criteria) ->
    (wave.findCreep(criteria) for wave in @currentWaves)
  placeTower: (tower, coordinates) ->
    @map.placeTower(tower, coordinates)
