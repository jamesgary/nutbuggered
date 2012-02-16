describe 'BoxerTower', ->
  beforeEach ->
    @direction = 'n'
    @coordinates = [5,2]
    NB.towerData = {
      BoxerTower: {
        cost: 50
        upgrades: {
          power: [
            {dmg: 10, cost: 0}
            {dmg: 25, cost: 100}
            {dmg: 35, cost: 150}
          ]
          range: [
            {sq: 1, cost: 0}
            {sq: 2, cost: 120}
            {sq: 3, cost: 250}
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
  describe 'upon creation', ->
    it 'costs 50', ->
      expect(@bt.cost).toEqual 50
    it 'has a power of 10 dmg', ->
      expect(@bt.power).toEqual 10
    it 'has a speed of 1.2', ->
      expect(@bt.speed).toEqual 1.2
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
  describe '#tick', ->
    beforeEach ->
      spyOn(@bt, 'attack')
    describe 'if cooled down', ->
      beforeEach ->
        @ticksUntilAttack = 0
      it 'attacks', ->
        @bt.tick()
        expect(@bt.attack).toHaveBeenCalled()
      it 'resets its ticks until attack', ->
        @bt.tick()
        expect(@bt.ticksUntilAttack).toEqual @bt.cooldown
    describe 'if not cooled down', ->
      beforeEach ->
        @bt.ticksUntilAttack = 5
      it 'does not attack', ->
        @bt.tick()
        expect(@bt.attack).not.toHaveBeenCalled()
      it 'decrements the ticks until attack', ->
        @bt.tick()
        expect(@bt.ticksUntilAttack).toEqual 4
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

  describe 'power upgrades', ->
    it '#canUpgradePower returns true', ->
      expect(@bt.canUpgradePower()).toBeTruthy()
    describe '#nextPowerUpgrade', ->
      it 'returns a hash of dmg and cost', ->
        expect(@bt.nextPowerUpgrade()).toEqual {dmg: 25, cost: 100}
      it 'returns null if already maxed out', ->
        @bt.upgradePower()
        @bt.upgradePower()
        expect(@bt.nextPowerUpgrade()).toEqual null
    describe '#upgradePower', ->
      it 'upgrades power', ->
        @bt.upgradePower()
        expect(@bt.power).toEqual 25

  it '#canUpgradeRange returns false', ->
    expect(@bt.canUpgradeRange()).toBeFalsy()

  describe 'speed upgrades', ->
    it '#canUpgradeSpeed returns true', ->
      expect(@bt.canUpgradeSpeed()).toBeTruthy()
    describe '#nextSpeedUpgrade', ->
      it 'returns a hash of rate and cost', ->
        expect(@bt.nextSpeedUpgrade()).toEqual {rate: .9, cost: 110}
      it 'returns null if already maxed out', ->
        @bt.upgradeSpeed()
        @bt.upgradeSpeed()
        expect(@bt.nextSpeedUpgrade()).toEqual null
    describe '#upgradeSpeed', ->
      it 'upgrades speed', ->
        @bt.upgradeSpeed()
        expect(@bt.speed).toEqual .9
