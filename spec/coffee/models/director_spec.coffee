describe 'Director', ->
  beforeEach ->
    @director = NB.Director
    @mockStage = {
      tick: ->
      load: ->,
    }
    spyOn(NB, 'Stage').andReturn(@mockStage)
  afterEach ->
    @director.end()
  describe 'when it starts', ->
    it 'creates a stage', ->
      @director.start()
      expect(NB.Director.stage).toEqual(@mockStage)
    it 'loads a map to the stage', ->
      @mockMap = {}
      spyOn(NB, 'Map').andReturn(@mockMap)
      spyOn(@mockStage, 'load')
      @director.start()
      expect(@mockStage.load).toHaveBeenCalledWith(@mockMap)
  describe 'after it starts', ->
    it 'ticks about 60 times per second', ->
      spyOn(@director, 'tick')
      @director.start()
      waits(1000)
      runs ->
        expect(@director.tick.callCount).toBeGreaterThan(40)
  describe '#tick', ->
    it 'ticks the stage', ->
      spyOn(@mockStage, 'tick')
      @director.start()
      @director.tick()
      expect(@mockStage.tick).toHaveBeenCalled()
