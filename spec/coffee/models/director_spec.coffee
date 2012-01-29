describe 'Director', ->
  beforeEach ->
    @director = NB.Director
    @mockStage = {
      tick: ->
      load: ->,
    }
    spyOn(NB, 'Stage').andReturn(@mockStage)
  describe 'when it starts', ->
    it 'creates a stage', ->
      @director.start()
      expect(NB.Director.stage).toEqual(@mockStage)
    it 'loads a map to the stage', ->
      @mockMap = {}
      spyOn(NB, 'Map').andReturn(@mockMap)
      spyOn(@mockStage, 'load')
      @director = NB.Director.start()
      expect(@mockStage.load).toHaveBeenCalledWith(@mockMap)
  describe 'after it starts', ->
    xit 'ticks about 60 times per second'
  describe '#tick', ->
    it 'ticks the stage', ->
      spyOn(@mockStage, 'tick')
      @director.start()
      @director.tick()
      expect(@mockStage.tick).toHaveBeenCalled()
