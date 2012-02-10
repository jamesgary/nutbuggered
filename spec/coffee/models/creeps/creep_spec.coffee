describe 'Creep', ->
  beforeEach ->
    @path = new NB.Path([[0,0], [10,0]])
    @creepData = {path: @path, hpMod: 1, speedMod: 1, waitMod: 1}
    @creep = new NB.Creep(@creepData)
  describe '#position', ->
    it 'starts at the path start', ->
      expect(@creep.position).toEqual([0,0])
  describe '#speed', ->
    it 'defaults to .01 per tick', ->
      expect(@creep.speed).toEqualAbout(.01)
  describe '#tick', ->
    it 'moves its speed down the path on a tick', ->
      @creep.tick()
      # TODO this is an integration test, but oh well
      expect(@creep.position).toEqual([0 + @creep.speed, 0])
  describe 'when constructed with modifiers', ->
    beforeEach ->
      @creepData = {path: @path, hpMod: 2, speedMod: 3, waitMod: 5}
      @modifiedCreep = new NB.Creep(@creepData)
    it 'should have modified hp', ->
      expect(@modifiedCreep.hp).toEqual(@creep.hp * 2)
    it 'should have a modified speed', ->
      expect(@modifiedCreep.speed).toEqual(@creep.speed * 3)
    it 'should have a modified wait', ->
      expect(@modifiedCreep.wait).toEqual(@creep.wait * 5)
  describe '#isInRange', ->
    it 'should find the creep', ->
      @creepData.path = new NB.Path([[1,1], [10,1]])
      @creep = new NB.Creep(@creepData)
      expect(@creep.isInRange([[0.51, 0.51]])).toBeTruthy()
      expect(@creep.isInRange([[0.51, 1.00]])).toBeTruthy()
      expect(@creep.isInRange([[0.51, 1.49]])).toBeTruthy()

      expect(@creep.isInRange([[1.00, 0.51]])).toBeTruthy()
      expect(@creep.isInRange([[1.00, 1.00]])).toBeTruthy()
      expect(@creep.isInRange([[1.00, 1.49]])).toBeTruthy()

      expect(@creep.isInRange([[1.49, 0.51]])).toBeTruthy()
      expect(@creep.isInRange([[1.49, 1.00]])).toBeTruthy()
      expect(@creep.isInRange([[1.49, 1.49]])).toBeTruthy()

      expect(@creep.isInRange([[1.51, 1.51]])).toBeFalsy()
      expect(@creep.isInRange([[0.49, 1.51]])).toBeFalsy()
      expect(@creep.isInRange([[0.49, 0.49]])).toBeFalsy()
  describe '#damage', ->
    it 'depletes hp', ->
      @creep.damage(1)
      expect(@creep.hp).toEqual 49
