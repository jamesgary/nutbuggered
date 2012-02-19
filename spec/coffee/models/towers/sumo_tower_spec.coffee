describe 'SumoTower', ->
  beforeEach ->
    @coordinates = [5,2]
    NB.towerData = {
      SumoTower: -> {
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
            {rate: 1.5, cost: 0}
            {rate: 1.1, cost: 110}
            {rate:  .7, cost: 230}
          ]
        }
      }
    }
    @st = new NB.SumoTower(@coordinates)
  describe '#attack', ->
    beforeEach ->
      @mockCreep1 = {damage: ->}
      @mockCreep2 = {damage: ->}
      spyOn(@mockCreep1, 'damage')
      spyOn(@mockCreep2, 'damage')
      NB.Director.level = {findCreep: ->}
      spyOn(NB.Director.level, 'findCreep').andReturn([@mockCreep1, @mockCreep2])
      spyOn(@st, 'drawAttack')
      @st.power = 20
      @st.attack()
    it 'hits all creep in its entire range for its power', ->
      expect(NB.Director.level.findCreep).toHaveBeenCalledWith(
        range: @st.range,
      )
      expect(@mockCreep1.damage).toHaveBeenCalledWith(20)
      expect(@mockCreep2.damage).toHaveBeenCalledWith(20)
  describe '#tick', ->
    it 'only ticks when a creep is in range'
    it 'resets when there is no creep in range'
