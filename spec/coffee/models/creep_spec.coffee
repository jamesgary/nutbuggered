describe 'Creep', ->
  #beforeEach ->
  #  @director = NB.Director
  #  @mockStage = {
  #    tick: ->
  #    load: ->,
  #  }
  #  spyOn(NB, 'Stage').andReturn(@mockStage)
  beforeEach ->
    @creep = new NB.Creep(new NB.Path([[0,0], [10,0]]))
  describe '#position', ->
    it 'starts at the path start', ->
      expect(@creep.position).toEqual([0,0])
  describe '#speed', ->
    it 'defaults to .001 per tick', ->
      expect(@creep.speed).toEqualAbout(.001)
  describe '#tick', ->
    it 'moves its speed down the path on a tick', ->
      @creep.tick()
      # TODO this is an integration test, but oh well
      expect(@creep.position).toEqual([0 + @creep.speed, 0])
