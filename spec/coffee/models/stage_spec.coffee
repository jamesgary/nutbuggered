describe 'Stage', ->
  beforeEach ->
    @stage = new NB.Stage()
  describe '.load', ->
    it 'draws the initial image for the object if possible', ->
      drawInitable = {drawInit: ->}
      spyOn(drawInitable, 'drawInit')
      @stage.load(drawInitable)
      expect(drawInitable.drawInit).toHaveBeenCalled()
  describe '.tick', ->
    it 'ticks all loaded tickables', ->
      tickable = {tick: ->}
      @stage.load(tickable)
      spyOn(tickable, 'tick')
      @stage.tick()
      expect(tickable.tick).toHaveBeenCalled()
    it "doesn't tick nontickables", ->
      nontickable = {}
      @stage.load(nontickable)
      @stage.tick() # don't throw exception
  describe '.draw', ->
    it 'draws all loaded drawables', ->
      drawable = {draw: ->}
      @stage.load(drawable)
      spyOn(drawable, 'draw')
      @stage.draw()
      expect(drawable.draw).toHaveBeenCalled()
    it "doesn't draw nondrawables", ->
      nondrawable = {}
      @stage.load(nondrawable)
      @stage.draw() # don't throw exception
