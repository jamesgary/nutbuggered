describe 'SlingshotTower', ->
  beforeEach ->
    @coordinates = [5,2]
    NB.towerData = {
      SlingshotTower: -> {
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
    @st = new NB.SlingshotTower(@coordinates, @direction)
  describe '#attack', ->
    beforeEach ->
      @mockCreep1 = {damage: ->}
      spyOn(@mockCreep1, 'damage')
      NB.Director.level = {findCreep: ->}
      spyOn(NB.Director.level, 'findCreep').andReturn([@mockCreep1])
      spyOn(@st, 'drawAttack')
      @st.power = 20
      @st.attack()
    it 'hits one creep for its entire range for its power', ->
      expect(NB.Director.level.findCreep).toHaveBeenCalledWith(
        range: @st.range,
        limit: 1,
        priority: @st.priority
      )
      expect(@mockCreep1.damage).toHaveBeenCalledWith(20)
