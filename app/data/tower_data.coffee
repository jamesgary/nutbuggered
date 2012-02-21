NB.towerData = {
  BoxerTower: -> {
    cost: 50
    upgrades: {
      power: [
        {dmg: 30, cost: 0}
        {dmg: 50, cost: 100}
        {dmg: 75, cost: 150}
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
    cost: 75
    upgrades: {
      power: [
        {dmg: 35, cost: 0}
        {dmg: 55, cost: 100}
        {dmg: 100, cost: 200}
        {dmg: 160, cost: 300}
        {dmg: 250, cost: 450}
      ]
      range: [
        {sq: 1, cost: 0}
        {sq: 2, cost: 100}
        {sq: 3, cost: 200}
      ]
      speed: [
        {rate: 1.2, cost: 0}
        {rate: .9, cost: 120}
        {rate: .6, cost: 200}
        {rate: .4, cost: 400}
        {rate: .2, cost: 600}
      ]
      special: [
        {description: "Ricochet your shot against nearby bugs", cost: 500}
        {description: "Projectiles split upon impact", cost: 500}
      ]
    }
  }
  SumoTower: -> {
    cost: 200
    upgrades: {
      power: [
        {dmg: 20, cost: 0}
        {dmg: 50, cost: 300}
        {dmg: 70, cost: 600}
        {dmg: 120, cost: 1000}
        {dmg: 200, cost: 1600}
      ]
      range: [
        {sq: 1, cost: 0}
        {sq: 2, cost: 400}
        {sq: 3, cost: 700}
      ]
      speed: [
        {rate: 1.7, cost: 0}
        {rate: 1.4, cost: 180}
        {rate: 1.2, cost: 350}
        {rate: 1.0, cost: 600}
        {rate: 0.8, cost: 1075}
      ]
      special: [
        {description: "20% chance to stun", cost: 1500}
        {description: "50% chance to stun", cost: 3500}
      ]
    }
  }
  ChillyTower: -> {
    cost: 200
    upgrades: {
      power: [
        {dmg: .25, cost: 0}
        {dmg: .35, cost: 200}
        {dmg: .45, cost: 400}
        {dmg: .55, cost: 800}
        {dmg: .65, cost: 1000}
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
  BazookaTower: -> {
    cost: 300
    upgrades: {
      power: [
        {dmg: 60, cost: 0}
        {dmg: 120, cost: 300}
        {dmg: 240, cost: 600}
        {dmg: 400, cost: 900}
        {dmg: 600, cost: 1500}
      ]
      range: [
        {sq: 3, cost: 0}
        {sq: 6, cost: 400}
        {sq: 16, cost: 1000}
      ]
      speed: [
        {rate: 1.6, cost: 0}
        {rate: 1.3, cost: 210}
        {rate: 1.0, cost: 430}
        {rate: 0.7, cost: 1000}
        {rate: 0.5, cost: 1875}
      ]
      special: [
        {description: "Pierce through 10 bugs", cost: 600}
        {description: "Pierce through 25 bugs", cost: 1000}
      ]
    }
  }
}
