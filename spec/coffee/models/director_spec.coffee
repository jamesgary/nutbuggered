describe 'Director', ->
  beforeEach ->
    window.webkitRequestAnimationFrame = -> # stub
    @director = NB.Director
    @levelData = {
      level: {
        placeTower: ->
        canPlaceTower: ->
      }
    }
  describe '#start', ->
    beforeEach ->
      spyOn(@director, 'tick')
    it 'starts the tick cycle', ->
      @director.start()
      expect(@director.tick).toHaveBeenCalled()
    it 'creates a stage', ->
      @mockStage = {}
      spyOn(NB, 'Stage').andReturn(@mockStage)
      @director.start()
      expect(@director.stage).toEqual(@mockStage)
  describe '#startLevel', ->
    it 'loads the level to the stage', ->
      @director.start()
      spyOn(@director.stage, 'load')
      @director.startLevel(@levelData)
      expect(@director.stage.load).toHaveBeenCalledWith(@levelData.level)
  describe '#tick', ->
    beforeEach ->
      @director.start()
      spyOn(@director.stage, 'tick')
      spyOn(@director.stage, 'draw')
      @director.tick()
    it 'ticks the stage', ->
      expect(@director.stage.tick).toHaveBeenCalled()
    it 'draws the stage', ->
      expect(@director.stage.draw).toHaveBeenCalled()
  describe '#placeTower', ->
    it 'places a tower in the level', ->
      tower = 'mockTower'
      coordinates = [2, 3]
      @director.start()
      spyOn(@director.level, 'placeTower')

      @director.placeTower(tower, coordinates)
      expect(@director.level.placeTower).toHaveBeenCalledWith(tower, [2, 3])
  describe '#canPlaceTower', ->
    beforeEach ->
      @mockTower = 'mockTower'
      @coordinates = [2, 3]
      @director.start()
      @director.startLevel(@levelData)
    describe 'if level can place tower', ->
      beforeEach ->
        spyOn(@director.level, 'canPlaceTower').andReturn(true)
      it 'returns true if level can place tower', ->
        expect(@director.canPlaceTower(@tower, @coordinates)).toBeTruthy()
    describe 'if level cannot place tower', ->
      beforeEach ->
        spyOn(@director.level, 'canPlaceTower').andReturn(false)
      it 'returns true if level can place tower', ->
        expect(@director.canPlaceTower(@tower, @coordinates)).toBeFalsy()
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

  ##describe 'after it starts', ->
  ##  # only works when using setInterval,
  ##  # webkitRequestAnimationFrame plays a little differently
  ##  xit 'ticks about 60 times per second', ->
  ##    spyOn(@director, 'tick')
  ##    @director.start()
  ##    waits(1000)
  ##    runs ->
  ##      expect(@director.tick.callCount).toBeGreaterThan(40)
