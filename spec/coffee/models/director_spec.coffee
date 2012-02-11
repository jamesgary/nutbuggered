describe 'Director', ->
  beforeEach ->
    @director = NB.Director
    @mockStage = {
      load: ->
      tick: ->
      draw: ->
    }
    spyOn(NB, 'Stage').andReturn(@mockStage)
    spyOn(@mockStage, 'load')
    @levelData = {
      level: {}
    }
  describe 'when it starts', ->
    beforeEach ->
      spyOn(@director, 'tick')
      @director.start(@levelData)
    it 'creates a stage', ->
      expect(@director.stage).toEqual(@mockStage)
    it 'loads a level to the stage', ->
      expect(@mockStage.load).toHaveBeenCalledWith(@levelData.level)
    it 'starts the tick cycle', ->
      expect(@director.tick).toHaveBeenCalled()
  #describe 'after it starts', ->
  #  # only works when using setInterval,
  #  # webkitRequestAnimationFrame plays a little differently
  #  xit 'ticks about 60 times per second', ->
  #    spyOn(@director, 'tick')
  #    @director.start()
  #    waits(1000)
  #    runs ->
  #      expect(@director.tick.callCount).toBeGreaterThan(40)
  describe '#tick', ->
    it 'ticks the stage', ->
      spyOn(@mockStage, 'tick')
      @director.start(@levelData)
      expect(@mockStage.tick).toHaveBeenCalled()
    it 'draws the stage', ->
      spyOn(@mockStage, 'draw')
      @director.start(@levelData)
      expect(@mockStage.draw).toHaveBeenCalled()
  #describe '#placeTower', ->
  #  it 'places a tower on the map', ->
  #    mockMap = {placeTower: ->}
  #    tower = 'mockTower'
  #    coordinates = [2, 3]
  #    NB.currentMap = mockMap
  #    spyOn(NB.currentMap, 'placeTower')
  #    @director.placeTower(tower, coordinates)
  #    expect(mockMap.placeTower).toHaveBeenCalledWith(tower, 2, 3)
