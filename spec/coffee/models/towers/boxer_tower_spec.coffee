describe 'BoxerTower', ->
  beforeEach ->
    @direction = 'n'
    @coordinates = [5,2]
    NB.towerData = {
      BoxerTower: -> {
        cost: 50
        upgrades: {
          power: [
            {dmg: 10, cost: 0}
            {dmg: 25, cost: 100}
            {dmg: 35, cost: 150}
          ]
          speed: [
            {rate: 1.2, cost: 0}
            {rate: .9, cost: 110}
            {rate: .6, cost: 230}
          ]
        }
      }
    }
    @bt = new NB.BoxerTower(@coordinates, @direction)
  describe 'range and direction', ->
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
  describe '#attack', ->
    it 'hits a creep in its range for its power', ->
      @mockCreep = {damage: {}}
      spyOn(@mockCreep, 'damage')
      NB.Director.level = {findCreep: ->}
      spyOn(NB.Director.level, 'findCreep').andReturn([[@mockCreep]])
      @bt.power = 20
      @bt.attack()
      expect(NB.Director.level.findCreep).toHaveBeenCalledWith({range: @bt.range})
      expect(@mockCreep.damage).toHaveBeenCalledWith(20)

  it 'can upgrade power', ->
    expect(@bt.canUpgradePower).toBeTruthy()
  it 'cannot upgrade range', ->
    expect(@bt.canUpgradeRange).toBeFalsy()
  it 'can upgrade speed', ->
    expect(@bt.canUpgradeSpeed).toBeTruthy()
