describe 'Tree', ->
  beforeEach ->
    @tree = new NB.Tree(1000)
  describe '#damage', ->
    it 'detracts hp', ->
      @tree.damage(10)
      expect(@tree.hp).toEqual 990
    it 'ends the game if it dies', ->
      spyOn(NB.Director, 'endGame')
      @tree.damage(1000)
      expect(NB.Director.endGame).toHaveBeenCalledWith(false)
    it "doesn't ends the game if it's still alive", ->
      spyOn(NB.Director, 'endGame')
      @tree.damage(999)
      expect(NB.Director.endGame).not.toHaveBeenCalled()
