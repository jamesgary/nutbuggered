NB.Level = class Level
  waveLifespan: 1200

  constructor: (data) ->
    @waves = for waveData in data.wavesData
      waveData.path = data.map.path
      new NB.Wave(waveData)
    @currentWaves = []
    @map = data.map
    @tree = data.tree
    @money = 1000
    @currentWaveIndex = 0
    @currentWaveAge = 0
  sendWave: (index) ->
    while @currentWaveIndex < index
      @sendNextWave()
  sendNextWave: ->
    @started = true
    if @waves.isEmpty()
      false
    else
      currentWave = @currentWaves[@currentWaves.length - 1]
      if currentWave
        currentWave.boostIncubatingCreepsMoney()
      @currentWaves.push(@waves.shift())
      @currentWaveIndex++
      @currentWaveAge = 0
      true
  tick: ->
    if @started
      @currentWaveAge++
      if (@currentWaveAge > @waveLifespan) && !@waves.isEmpty()
        @sendNextWave()
    wave.tick() for wave in @currentWaves
    @map.tick()
  findCreep: (criteria) ->
    # example criteria:
    # { range: [[4,5],[4,6]], limitPerRange: 1, limit: 2, priority: NB.TargetPriority.FIRST }
    # and maybe { avoid: [instanceof NB.Creep] } for chaining attacks
    range = criteria.range
    priority = criteria.priority
    limit = criteria.limit
    limitPerRange = criteria.limitPerRange
    sorter = @createPrioritySorter(priority)
    allCreep = @getAllCreep()
    foundCreep = []

    if limitPerRange
      for cell in range
        foundCreepInCell = []
        for creep in allCreep
          foundCreepInCell.push creep if creep.isInRange cell
        if foundCreepInCell.length > limitPerRange
          foundCreepInCell = foundCreepInCell.sort(sorter)
          foundCreepInCell = foundCreepInCell.slice 0, limitPerRange
        foundCreep = foundCreep.concat(foundCreepInCell)
    else if limit
      for cell in range
        for creep in allCreep
          foundCreep.push creep if creep.isInRange cell
      if foundCreep.length > limit
        foundCreep = foundCreep.sort(sorter)
        foundCreep = foundCreep.slice 0, limit

    else # no limits
      for cell in range
        for creep in allCreep
          foundCreep.push creep if creep.isInRange cell
    foundCreep
  placeTower: (tower, coordinates) ->
    @map.placeTower(tower, coordinates)
    @chargeMoney(tower.cost)
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
  grantMoney: (dollars) ->
    @money += dollars
  chargeMoney: (dollars) ->
    @money -= dollars
  canAfford: (dollars) ->
    @money >= dollars

  # private

  getAllCreep: ->
    allCreep = []
    allCreep = allCreep.concat(wave.liveCreeps) for wave in @currentWaves
    allCreep
  createPrioritySorter: (priority) ->
    switch priority
      when NB.Priorities.FIRST
        sorter = (a,b) ->
          a.traveled < b.traveled
      when NB.Priorities.LAST
        sorter = (a,b) ->
          a.traveled > b.traveled
      when NB.Priorities.STRONGEST
        sorter = (a,b) ->
          a.hp < b.hp
      when NB.Priorities.WEAKEST
        sorter = (a,b) ->
          a.hp > b.hp
    sorter
