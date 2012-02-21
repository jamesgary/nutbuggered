describe 'BazookaTower', ->
  beforeEach ->
    @direction = 'n'
    @coordinates = [5,2]
    NB.towerData = {
      BazookaTower: -> {
        cost: 600
        upgrades: {
          power: [
            {dmg: 10, cost: 0}
            {dmg: 25, cost: 100}
            {dmg: 35, cost: 150}
          ]
          range: [
            {sq: 2, cost: 0}
            {sq: 6, cost: 120}
            {sq: 16, cost: 250}
          ]
          speed: [
            {rate: 1.2, cost: 0}
            {rate: .9, cost: 110}
            {rate: .6, cost: 230}
          ]
        }
      }
    }
    @bazooka = new NB.BazookaTower(@coordinates, @direction)
  describe '#attack', ->
    beforeEach ->
      @mockCreep1 = {damage: ->}
      @mockCreep2 = {damage: ->}
      spyOn(@mockCreep1, 'damage')
      spyOn(@mockCreep2, 'damage')
      NB.Director.level = {findCreep: ->}
      spyOn(NB.Director.level, 'findCreep').andReturn([@mockCreep1, @mockCreep2])
      spyOn(@bazooka, 'drawAttack')
      @bazooka.power = 20
      @bazooka.pierceLimit = 2
      @bazooka.attack()
    it 'hits several creeps for its entire range for its power', ->
      expect(NB.Director.level.findCreep).toHaveBeenCalledWith(
        range: @bazooka.range,
        limit: 2,
      )
      expect(@mockCreep1.damage).toHaveBeenCalledWith(20)
  # FIXME copied from boxer tower spec
  describe 'range and direction', ->
    # @coordinates = [5,2]
    describe 'north facing', ->
      beforeEach ->
        @bazooka = new NB.BazookaTower(@coordinates, 'n')
      it 'has a range and direction', ->
        expect(@bazooka.direction).toEqual 'n'
        expect(@bazooka.range).toContain [5,1]
        expect(@bazooka.range).toContain [5,0]
        expect(@bazooka.range.length).toBe 2
    describe 'east facing', ->
      beforeEach ->
        @bazooka = new NB.BazookaTower(@coordinates, 'e')
      it 'has a range and direction', ->
        expect(@bazooka.direction).toEqual 'e'
        expect(@bazooka.range).toContain [6,2]
        expect(@bazooka.range).toContain [7,2]
        expect(@bazooka.range.length).toBe 2
    describe 'south facing', ->
      beforeEach ->
        @bazooka = new NB.BazookaTower(@coordinates, 's')
      it 'has a range and direction', ->
        expect(@bazooka.direction).toEqual 's'
        expect(@bazooka.range).toContain [5,3]
        expect(@bazooka.range).toContain [5,4]
        expect(@bazooka.range.length).toBe 2
    describe 'west facing', ->
      beforeEach ->
        @bazooka = new NB.BazookaTower(@coordinates, 'w')
      it 'has a range and direction', ->
        expect(@bazooka.direction).toEqual 'w'
        expect(@bazooka.range).toContain [4,2]
        expect(@bazooka.range).toContain [3,2]
        expect(@bazooka.range.length).toBe 2

  it 'can upgrade power', ->
    expect(@bazooka.canUpgradePower).toBeTruthy()
  it 'can upgrade range', ->
    expect(@bazooka.canUpgradeRange).toBeTruthy()
  it 'can upgrade speed', ->
    expect(@bazooka.canUpgradeSpeed).toBeTruthy()

