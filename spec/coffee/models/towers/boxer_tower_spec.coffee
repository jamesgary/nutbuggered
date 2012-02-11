describe 'BoxerTower', ->
  beforeEach ->
    @direction = 'n'
    @coordinates = [5,2]
    @bt = new NB.BoxerTower(@coordinates, @direction)
  it 'costs 50', ->
    expect(@bt.cost).toEqual 50
  describe 'north facing', ->
    beforeEach ->
      @bt = new NB.BoxerTower(@coordinates, 'n')
    it 'has a range and direction', ->
      expect(@bt.direction).toEqual 'n'
      expect(@bt.range).toEqual [[5,1]]
  describe 'east facing', ->
    beforeEach ->
      @bt = new NB.BoxerTower(@coordinates, 'e')
    it 'has a range and direction', ->
      expect(@bt.direction).toEqual 'e'
      expect(@bt.range).toEqual [[6,2]]
  describe 'south facing', ->
    beforeEach ->
      @bt = new NB.BoxerTower(@coordinates, 's')
    it 'has a range and direction', ->
      expect(@bt.direction).toEqual 's'
      expect(@bt.range).toEqual [[5,3]]
  describe 'west facing', ->
    beforeEach ->
      @bt = new NB.BoxerTower(@coordinates, 'w')
    it 'has a range and direction', ->
      expect(@bt.direction).toEqual 'w'
      expect(@bt.range).toEqual [[4,2]]
  describe '#tick', ->
    describe 'hits a creep in its range for 20 dmg', ->
      it 'hits a creep in its range', ->
        mockCreep = {damage: {}}
        spyOn(mockCreep, 'damage')
        NB.Director.level = {findCreep: ->}
        spyOn(NB.Director.level, 'findCreep').andReturn([mockCreep])

        @bt.tick()

        expect(NB.Director.level.findCreep).toHaveBeenCalledWith({range: @bt.range})
        expect(mockCreep.damage).toHaveBeenCalledWith(20)
