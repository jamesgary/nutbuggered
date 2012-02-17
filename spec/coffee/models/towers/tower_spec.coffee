describe 'Tower', ->
  describe 'basic tower', ->
    beforeEach ->
      NB.towerData = {
        BasicTower: -> {
          cost: 100
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
      NB.BasicTower = class BasicTower extends NB.Tower
        constructor: (@coordinates) ->
          data = NB.towerData.BasicTower()
          super(data)
      @coordinates = [5,2]
      @tower = new NB.BasicTower(@coordinates)
    describe 'upon creation', ->
      it 'exists', ->
        expect(@tower).toNotBe undefined
      it 'has a position', ->
        expect(@tower.coordinates).toEqual [5,2]
      it 'costs the amount given in NB.towerData', ->
        expect(@tower.cost).toEqual 100
      it 'has the power given in NB.towerData', ->
        expect(@tower.power).toEqual 10
      it 'has the speed given in NB.towerData', ->
        expect(@tower.speed).toEqual 1.2
      it 'has the range given in NB.towerData', ->
        cellsInRange = [
          [4,1], [4,2], [4,3]
          [5,1], [5,2], [5,3]
          [6,1], [6,2], [6,3]
        ]
        expect(@tower.range).toContain cell for cell in cellsInRange
        expect(@tower.range.length).toEqual 9
    describe '#tick', ->
      beforeEach ->
      describe 'if cooled down', ->
        beforeEach ->
          @ticksUntilAttack = 0
        it 'attacks successfully', ->
          spyOn(@tower, 'attack')
          @tower.tick()
          expect(@tower.attack).toHaveBeenCalled()
        it 'resets its ticks until attack if attack was successful', ->
          spyOn(@tower, 'attack').andReturn true
          @tower.tick()
          expect(@tower.ticksUntilAttack).toEqual @tower.cooldown
        it 'does not reset its ticks until attack if attack was unsuccessful', ->
          spyOn(@tower, 'attack').andReturn false
          @tower.tick()
          expect(@tower.ticksUntilAttack).toEqual 0
      describe 'if not cooled down', ->
        beforeEach ->
          spyOn(@tower, 'attack')
          @tower.ticksUntilAttack = 5
        it 'does not attack', ->
          @tower.tick()
          expect(@tower.attack).not.toHaveBeenCalled()
        it 'decrements the ticks until attack', ->
          @tower.tick()
          expect(@tower.ticksUntilAttack).toEqual 4

    ##############
    #  UPGRADES  #
    ##############

    describe 'upgrades', ->
      describe 'power upgrades', ->
        it '#canUpgradePower returns true', ->
          expect(@tower.canUpgradePower).toBeTruthy()
        describe '#nextPowerUpgrade', ->
          it 'returns a hash of dmg and cost', ->
            expect(@tower.nextPowerUpgrade()).toEqual {dmg: 25, cost: 100}
          it 'returns null if already maxed out', ->
            @tower.upgradePower()
            @tower.upgradePower()
            expect(@tower.nextPowerUpgrade()).toBe null
        describe '#upgradePower', ->
          it 'upgrades power', ->
            @tower.upgradePower()
            expect(@tower.power).toEqual 25

      describe 'range upgrades', ->
        it '#canUpgradeRange returns true', ->
          expect(@tower.canUpgradeRange).toBeTruthy()
        describe '#nextRangeUpgrade', ->
          it 'returns a hash of sq and cost', ->
            expect(@tower.nextRangeUpgrade()).toEqual {sq: 2, cost: 120}
          it 'returns null if already maxed out', ->
            @tower.upgradeRange()
            @tower.upgradeRange()
            expect(@tower.nextRangeUpgrade()).toBe null
        describe '#refreshRange', ->
          it 'refreshes the range', ->
            @tower.coordinates = [8, 4]
            @tower.refreshRange()
            cellsInRange = [
              [7,3], [7,4], [7,5]
              [8,3], [8,4], [8,5]
              [9,3], [9,4], [9,5]
            ]
            expect(@tower.range).toContain cell for cell in cellsInRange
            expect(@tower.range.length).toEqual 9
        describe '#upgradeRange', ->
          it 'upgrades range', ->
            @tower.upgradeRange()
            cellsInRange = [
              [3,0], [3,1], [3,2], [3,3], [3,4]
              [4,0], [4,1], [4,2], [4,3], [4,4]
              [5,0], [5,1], [5,2], [5,3], [5,4]
              [6,0], [6,1], [6,2], [6,3], [6,4]
              [7,0], [7,1], [7,2], [7,3], [7,4]
            ]
            expect(@tower.range).toContain cell for cell in cellsInRange
            expect(@tower.range.length).toEqual 25

      describe 'speed upgrades', ->
        it '#canUpgradeSpeed returns true', ->
          expect(@tower.canUpgradeSpeed).toBeTruthy()
        describe '#nextSpeedUpgrade', ->
          it 'returns a hash of rate and cost', ->
            expect(@tower.nextSpeedUpgrade()).toEqual {rate: .9, cost: 110}
          it 'returns null if already maxed out', ->
            @tower.upgradeSpeed()
            @tower.upgradeSpeed()
            expect(@tower.nextSpeedUpgrade()).toBe null
        describe '#upgradeSpeed', ->
          it 'upgrades speed', ->
            @tower.upgradeSpeed()
            expect(@tower.speed).toEqual .9

  describe 'limited tower', ->
    beforeEach ->
      NB.towerData = {
        LimitedTower: -> {
          cost: 100
          upgrades: {
          }
        }
      }
      NB.LimitedTower = class LimitedTower extends NB.Tower
        constructor: (@coordinates) ->
          data = NB.towerData.LimitedTower()
          super(data)
      @coordinates = [5,2]
      @tower = new NB.LimitedTower(@coordinates)
    it 'cannot upgrade power', ->
      expect(@tower.canUpgradePower).toBeFalsy()
    it 'cannot upgrade range', ->
      expect(@tower.canUpgradeRange).toBeFalsy()
    it 'cannot upgrade speed', ->
      expect(@tower.canUpgradeSpeed).toBeFalsy()
