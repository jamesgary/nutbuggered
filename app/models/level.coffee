NB.Level = class Level
  constructor: (data) ->
    @waves = for waveData in data.wavesData
      waveData.path = data.map.path
      new NB.Wave(waveData)
    @currentWaves = []
    @map = data.map
    @tree = data.tree
  sendNextWave: ->
    if @waves.isEmpty()
      false
    else
      @currentWaves.push(@waves.shift())
      true
  tick: ->
    wave.tick() for wave in @currentWaves
    @map.tick()
  findCreep: (criteria) ->
    (wave.findCreep(criteria) for wave in @currentWaves)
  placeTower: (tower, coordinates) ->
    @map.placeTower(tower, coordinates)
  canPlaceTower: (tower, coordinates) ->
    @map.canPlaceTower(tower, coordinates)
  checkForVictory: ->
    return false if @waves.length > 0
    for wave in @currentWaves
      return false if wave.isAlive()
    true
  notifyCompletionOf: (completedWave) ->
    @currentWaves.remove(completedWave)
    if @currentWaves.isEmpty() && @waves.isEmpty()
      NB.Director.endGame(true)
  removeTower: (tower) ->
    @map.removeTower(tower)
