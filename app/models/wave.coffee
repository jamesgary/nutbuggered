NB.Wave = class Wave
  constructor: (data) ->
    creepData = data.creepData
    creepData.path = data.path
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
  findCreep: (criteria) ->
    range = criteria.range
    (creep for creep in @liveCreeps when creep.isInRange(range))

  #private

  shouldSpawn: ->
    @incubatingCreeps.length > 0 && @age >= @nextSpawnTime
