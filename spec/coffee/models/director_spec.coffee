describe 'Director', ->
  beforeEach ->
    window.webkitRequestAnimationFrame = -> # stub
    @director = NB.Director
    @mockStage = {
      load: ->
      tick: ->
      draw: ->
    }
    spyOn(NB, 'Stage').andReturn(@mockStage)
    spyOn(@mockStage, 'load')
    @levelData = {
      level: {placeTower: ->}
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
  describe '#placeTower', ->
    it 'places a tower in the level', ->
      tower = 'mockTower'
      coordinates = [2, 3]
      @director.start(@levelData)
      spyOn(@director.level, 'placeTower')

      @director.placeTower(tower, coordinates)
      expect(@director.level.placeTower).toHaveBeenCalledWith(tower, [2, 3])
  describe '#endGame', ->
    describe 'win', ->
      it 'congratulates', ->
        @director.start(@levelData)
        spyOn(console, 'log')
        @director.endGame(true)
        expect(console.log).toHaveBeenCalledWith('A winner is you!')
    describe 'lose', ->
      it 'disparages', ->
        @director.start(@levelData)
        spyOn(console, 'log')
        @director.endGame(false)
        expect(console.log).toHaveBeenCalledWith('A loser is you!')
