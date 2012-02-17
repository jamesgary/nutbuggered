NB.towerData = {
  BoxerTower: -> {
    cost: 50
    upgrades: {
      power: [
        {dmg: 10, cost: 0}
        {dmg: 25, cost: 100}
        {dmg: 35, cost: 150}
        {dmg: 60, cost: 250}
        {dmg: 100, cost: 350}
      ]
      speed: [
        {rate: 1.2, cost: 0}
        {rate: .9, cost: 110}
        {rate: .6, cost: 230}
        {rate: .4, cost: 500}
        {rate: .2, cost: 875}
      ]
    }
  }
}
