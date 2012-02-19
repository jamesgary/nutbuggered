NB.levelData = {
  level1: ->
    {
      level: new NB.Level({
        wavesData: [
          {creepData: {type: NB.Creep, money: 20,  hpMod: 1,    speedMod: 1,   countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Creep, money: 35,  hpMod: 1.2,  speedMod: 1.1, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Creep, money: 10,  hpMod: 0.5,  speedMod: 1.4, countMod: 2.5, waitMod: .3}} # swarm
          {creepData: {type: NB.Creep, money: 70,  hpMod: 1.5,  speedMod: 1.2, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Creep, money: 80,  hpMod: 1.0,  speedMod: 2.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Creep, money: 20,  hpMod: 0.7,  speedMod: 1.2, countMod: 2.5, waitMod: .3}} # swarm
          {creepData: {type: NB.Creep, money: 110, hpMod: 2.0,  speedMod: 1.0, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Creep, money: 150, hpMod: 1.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Creep, money: 50,  hpMod: 0.7,  speedMod: 1.2, countMod: 3.5, waitMod: .2}} # swarm
          {creepData: {type: NB.Creep, money: 380, hpMod: 20.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
        ]
        map: new NB.Map({path: new NB.Path([
          [7,  6]
          [13, 6]
          [13, 1]
          [10, 1]
          [10, 3]
          [4,  3]
          [4,  8]
          [1,  8]
          [1,  11]
          [6,  11]
          [6,  8]
          [14, 8]
          [14, 14]
          [8,  14]
          [8,  11]
          [10, 11]
        ])})
        tree: new NB.Tree(1000, [10, 11])
      })
    }
}
