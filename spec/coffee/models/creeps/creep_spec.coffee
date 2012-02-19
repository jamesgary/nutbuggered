describe 'Creep', ->
  beforeEach ->
    @path = new NB.Path([[0,0], [10,0]])
    @parentWave = {notifyDeathOf: ->}
    @creepData = {path: @path, hpMod: 1, speedMod: 1, waitMod: 1, money: 3, parentWave: @parentWave}
    @creep = new NB.Creep(@creepData)
    @mockDirector = {
      level: {
        tree: {damage: ->}
        grantMoney: ->
      }
    }
    NB.Director = @mockDirector
  describe '#position', ->
    it 'starts at the path start', ->
      expect(@creep.position).toEqual([0,0])
  describe '#speed', ->
    it 'defaults to .02 per tick', ->
      expect(@creep.speed).toEqualAbout(.02)
  describe '#tick', ->
    describe 'when it can move', ->
      beforeEach ->
        @creep.position = [0,0]
      it 'moves its speed down the path on a tick', ->
        @creep.tick()
        # TODO this is an integration test, but oh well
        expect(@creep.position).toEqual([0 + @creep.speed, 0])
      it 'marks how far it traveled', ->
        expect(@creep.traveled).toEqual 0
        @creep.tick()
        expect(@creep.traveled).toEqual @creep.speed
    describe 'when it cannot move', ->
      beforeEach ->
        @creep.position = [10,0]
      it 'eats away at the tree', ->
        spyOn(@mockDirector.level.tree, 'damage')
        @creep.tick()
        expect(@mockDirector.level.tree.damage).toHaveBeenCalledWith(@creep.bitePower)
  describe 'when constructed with modifiers', ->
    beforeEach ->
      @creepData = {path: @path, hpMod: 2, speedMod: 3, waitMod: 5, money: 3}
      @modifiedCreep = new NB.Creep(@creepData)
    it 'should have modified hp', ->
      expect(@modifiedCreep.hp).toEqual(@creep.hp * 2)
    it 'should have a modified speed', ->
      expect(@modifiedCreep.speed).toEqual(@creep.speed * 3)
    it 'should have a modified wait', ->
      expect(@modifiedCreep.wait).toEqual(@creep.wait * 5)
    it 'should have the given money', ->
      expect(@modifiedCreep.money).toEqual(3)
  describe '#isInRange', ->
    it 'should find the creep', ->
      @creepData.path = new NB.Path([[1,1], [10,1]])
      @creep = new NB.Creep(@creepData)
      expect(@creep.isInRange([0.51, 0.51])).toBeTruthy()
      expect(@creep.isInRange([0.51, 1.00])).toBeTruthy()
      expect(@creep.isInRange([0.51, 1.49])).toBeTruthy()

      expect(@creep.isInRange([1.00, 0.51])).toBeTruthy()
      expect(@creep.isInRange([1.00, 1.00])).toBeTruthy()
      expect(@creep.isInRange([1.00, 1.49])).toBeTruthy()

      expect(@creep.isInRange([1.49, 0.51])).toBeTruthy()
      expect(@creep.isInRange([1.49, 1.00])).toBeTruthy()
      expect(@creep.isInRange([1.49, 1.49])).toBeTruthy()

      expect(@creep.isInRange([1.51, 1.51])).toBeFalsy()
      expect(@creep.isInRange([0.49, 1.51])).toBeFalsy()
      expect(@creep.isInRange([0.49, 0.49])).toBeFalsy()
  describe '#damage', ->
    it 'depletes hp', ->
      @creep.damage(10)
      expect(@creep.hp).toEqual 40
    it 'dies if it runs out of health', ->
      spyOn(@creep, 'die')
      @creep.damage(50)
      expect(@creep.die).toHaveBeenCalled()
  describe '#isAlive', ->
    describe 'when it has health', ->
      beforeEach ->
        @creep.health = 42
      it 'return true', ->
        expect(@creep.isAlive()).toBeTruthy()
    describe 'when it does not health', ->
      beforeEach ->
        @creep.health = 0
      it 'return false', ->
        expect(@creep.isAlive()).toBeFalsy()
  describe '#die', ->
    it 'grants money', ->
      spyOn(NB.Director.level, 'grantMoney')
      @creep.die()
      expect(NB.Director.level.grantMoney).toHaveBeenCalledWith(@creep.money)
    it 'tells the wave that it died', ->
      spyOn(@creep.parentWave, 'notifyDeathOf')
      @creep.die()
      expect(@creep.parentWave.notifyDeathOf).toHaveBeenCalledWith(@creep)
