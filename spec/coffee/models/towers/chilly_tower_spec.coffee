describe 'ChillyTower', ->
  beforeEach ->
    @coordinates = [5,2]
    NB.towerData = {
      ChillyTower: -> {
        cost: 100
        upgrades: {
          power: [
            {dmg: .05, cost: 0}
            {dmg: .1, cost: 500}
            {dmg: .15, cost: 900}
            {dmg: .2, cost: 1600}
            {dmg: .25, cost: 2800}
          ]
          range: [
            {sq: 1, cost: 0}
            {sq: 2, cost: 400}
            {sq: 3, cost: 700}
          ]
        }
      }
    }
    @chilly = new NB.ChillyTower(@coordinates)
  describe '#attack', ->
    beforeEach ->
      @mockCreep1 = {slow: ->}
      @mockCreep2 = {slow: ->}
      spyOn(@mockCreep1, 'slow')
      spyOn(@mockCreep2, 'slow')
      NB.Director.level = {findCreep: ->}
      spyOn(NB.Director.level, 'findCreep').andReturn([@mockCreep1, @mockCreep2])
      spyOn(@chilly, 'drawAttack') # stub
      @chilly.power = .05
      @chilly.attack()
    it 'slows all creep in its entire range for its power', ->
      expect(NB.Director.level.findCreep).toHaveBeenCalledWith(
        range: @chilly.range,
      )
      expect(@mockCreep1.slow).toHaveBeenCalledWith(.05)
      expect(@mockCreep2.slow).toHaveBeenCalledWith(.05)
  describe '#tick', ->
    it 'constantly attacked', ->
      @chilly.cooldown = 50
      spyOn(@chilly, 'attack').andReturn true
      @chilly.tick()
      @chilly.tick()
      @chilly.tick()
      expect(@chilly.attack.callCount).toBe 3
