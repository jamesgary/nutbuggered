describe 'Creep', ->
  beforeEach ->
    @path = new NB.Path([[0,0], [10,0]])
    NB.currentMap = new NB.Map({path: @path})
    @creepData = {hpMod: 1, speedMod: 1, waitMod: 1}

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
      @creepData = {hpMod: 2, speedMod: 3, waitMod: 5}
      @modifiedCreep = new NB.Creep(@creepData)
    it 'should have modified hp', ->
      expect(@modifiedCreep.hp).toEqual(@creep.hp * 2)
    it 'should have a modified speed', ->
      expect(@modifiedCreep.speed).toEqual(@creep.speed * 3)
    it 'should have a modified wait', ->
      expect(@modifiedCreep.wait).toEqual(@creep.wait * 5)
