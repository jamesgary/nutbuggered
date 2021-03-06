NB.Wave = class Wave
  constructor: (data) ->
    creepData = data.creepData
    creepData.path = data.path
    creepData.parentWave = this
    CreepType = creepData.type
    mold = new CreepType(creepData)
    numCreepToSpawn = creepData.countMod * mold.defaultCount

    @age = 0
    @totalCreepsSpawned = 0
    @liveCreeps = []
    @incubatingCreeps = []
    @incubatingCreeps.push(new CreepType(creepData)) for i in [1..numCreepToSpawn]
    @waitTime = creepData.waitMod * mold.defaultWait
    @nextSpawnTime = 0
  tick: ->
    @age++
    if @shouldSpawn()
      @liveCreeps.push(@incubatingCreeps.pop())
      @totalCreepsSpawned++
      @nextSpawnTime = @totalCreepsSpawned * @waitTime
    creep.tick() for creep in @liveCreeps
  isAlive: ->
    return true if @incubatingCreeps.length > 0
    for creep in @liveCreeps
      return true if creep.isAlive()
    false
  notifyDeathOf: (creep) ->
    @liveCreeps.remove(creep)
    if @incubatingCreeps.isEmpty() && @liveCreeps.isEmpty()
      NB.Director.level.notifyCompletionOf(this)
  boostIncubatingCreepsMoney: ->
    creep.money = creep.money * 1.2 for creep in @incubatingCreeps

  #private

  shouldSpawn: ->
    @incubatingCreeps.length > 0 && @age >= @nextSpawnTime
