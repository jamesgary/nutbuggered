NB.towerData = {
  BoxerTower: -> {
    cost: 50
    upgrades: {
      power: [
        {dmg: 20, cost: 0}
        {dmg: 50, cost: 100}
        {dmg: 70, cost: 150}
        {dmg: 120, cost: 250}
        {dmg: 200, cost: 350}
      ]
      speed: [
        {rate: .7, cost: 0}
        {rate: .5, cost: 110}
        {rate: .4, cost: 230}
        {rate: .3, cost: 500}
        {rate: .2, cost: 875}
      ]
      special: [
        {description: "Tail whip a bug behind you", cost: 200}
        {description: "Roundhouse kick a bug in each in-range cell", cost: 500}
      ]
    }
  }
  SlingshotTower: -> {
    cost: 100
    upgrades: {
      power: [
        {dmg: 25, cost: 0}
        {dmg: 45, cost: 100}
        {dmg: 80, cost: 200}
        {dmg: 110, cost: 300}
        {dmg: 180, cost: 450}
      ]
      range: [
        {sq: 1, cost: 0}
        {sq: 2, cost: 300}
        {sq: 3, cost: 500}
      ]
      speed: [
        {rate: 1.2, cost: 0}
        {rate: .9, cost: 190}
        {rate: .6, cost: 330}
        {rate: .4, cost: 600}
        {rate: .2, cost: 1075}
      ]
      special: [
        {description: "Ricochet your shot against nearby bugs", cost: 500}
        {description: "Projectiles split upon impact", cost: 500}
      ]
    }
  }
  SumoTower: -> {
    cost: 350
    upgrades: {
      power: [
        {dmg: 20, cost: 0}
        {dmg: 50, cost: 500}
        {dmg: 70, cost: 900}
        {dmg: 120, cost: 1600}
        {dmg: 200, cost: 2800}
      ]
      range: [
        {sq: 1, cost: 0}
        {sq: 2, cost: 400}
        {sq: 3, cost: 700}
      ]
      speed: [
        {rate: 1.7, cost: 0}
        {rate: 1.4, cost: 210}
        {rate: 1.2, cost: 430}
        {rate: 1.0, cost: 1000}
        {rate: 0.8, cost: 1875}
      ]
      special: [
        {description: "20% chance to stun", cost: 1500}
        {description: "50% chance to stun", cost: 3500}
      ]
    }
  }
  ChillyTower: -> {
    cost: 500
    upgrades: {
      power: [
        {dmg: .20, cost: 0}
        {dmg: .30, cost: 500}
        {dmg: .40, cost: 900}
        {dmg: .50, cost: 1600}
        {dmg: .60, cost: 2800}
      ]
      range: [
        {sq: 1, cost: 0}
        {sq: 2, cost: 400}
        {sq: 3, cost: 700}
      ]
      special: [
        {description: "Bugs takes a few seconds to thaw", cost: 1000}
        {description: "Bugs are permanently slowed", cost: 5000}
      ]
    }
  }
}
