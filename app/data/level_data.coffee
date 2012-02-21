NB.levelData = {
  easy: ->
    {
      level: new NB.Level({
        wavesData: [
          {creepData: {type: NB.Ant, money: 20,  hpMod: .5,    speedMod: 1,   countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 35,  hpMod: 1.0,  speedMod: 1.1, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 10,  hpMod: 0.5,  speedMod: 1.4, countMod: 2.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Ant, money: 50,  hpMod: 2.2,  speedMod: 1.2, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 60,  hpMod: 2.0,  speedMod: 2.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 20,  hpMod: 1.7,  speedMod: 1.2, countMod: 2.5, waitMod: .3}} # swarm
          {creepData: {type: NB.Ant, money: 100, hpMod: 3.0,  speedMod: .8, countMod: .5, waitMod: 2}} # basic
          {creepData: {type: NB.Ant, money: 80, hpMod: 3.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 30,  hpMod: 2.7,  speedMod: 1.2, countMod: 3.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Creep, money: 380, hpMod: 20.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
        ]
        map: new NB.Map({path: new NB.Path([
          [3,11 ]
          [12,11]
          [12,9 ]
          [3,9  ]
          [3,3  ]
          [5,3  ]
          [5,7  ]
          [7,7  ]
          [7,3  ]
          [9,3  ]
          [9,7  ]
          [14,7 ]
          [14,14]
          [12,14]
          [12,13]
          [10,13]
          [10,14]
          [5,14 ]
          [5,13 ]
          [3,13 ]
          [3,14 ]
          [1,14 ]
          [1,1  ]
          [11,1 ]
          [11,5 ]
          [13,5 ]
        ])})
        tree: new NB.Tree(500, [13, 5])
      })
    }
  medium: ->
    {
      level: new NB.Level({
        wavesData: [
          {creepData: {type: NB.Ant, money: 20,  hpMod: .5,    speedMod: 1,   countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 35,  hpMod: 1.0,  speedMod: 1.1, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 10,  hpMod: 0.5,  speedMod: 1.4, countMod: 2.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Ant, money: 50,  hpMod: 2.2,  speedMod: 1.2, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 60,  hpMod: 2.0,  speedMod: 2.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 20,  hpMod: 1.7,  speedMod: 1.2, countMod: 2.5, waitMod: .3}} # swarm
          {creepData: {type: NB.Ant, money: 100, hpMod: 3.0,  speedMod: .8, countMod: .5, waitMod: 2}} # basic
          {creepData: {type: NB.Ant, money: 80, hpMod: 4.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 30,  hpMod: 2.7,  speedMod: 1.2, countMod: 3.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Creep, money: 480, hpMod: 25.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
          {creepData: {type: NB.Ant, money: 120, hpMod: 4.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 40,  hpMod: 3.7,  speedMod: 1.2, countMod: 3.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Creep, money: 700, hpMod: 35.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
        ]
        map: new NB.Map({path: new NB.Path([
          [7,  6]
          [13, 6]
          [13, 1]
          [11, 1]
          [11, 3]
          [4,  3]
          [4,  9]
          [1,  9]
          [1,  11]
          [6,  11]
          [6,  8]
          [14, 8]
          [14, 14]
          [8,  14]
          [8,  11]
          [10, 11]
        ])})
        tree: new NB.Tree(500, [10, 11])
      })
    }
  hard: ->
    {
      level: new NB.Level({
        wavesData: [
          {creepData: {type: NB.Ant, money: 20,  hpMod: .5,    speedMod: 1,   countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 35,  hpMod: 1.0,  speedMod: 1.1, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 10,  hpMod: 0.5,  speedMod: 1.4, countMod: 2.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Ant, money: 50,  hpMod: 2.2,  speedMod: 1.2, countMod: 1.0, waitMod: 1}} # basic
          {creepData: {type: NB.Ant, money: 60,  hpMod: 2.0,  speedMod: 2.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 20,  hpMod: 1.7,  speedMod: 1.2, countMod: 2.5, waitMod: .3}} # swarm
          {creepData: {type: NB.Ant, money: 100, hpMod: 3.0,  speedMod: .8, countMod: .5, waitMod: 2}} # basic
          {creepData: {type: NB.Ant, money: 80, hpMod: 4.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 30,  hpMod: 2.7,  speedMod: 1.2, countMod: 3.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Creep, money: 480, hpMod: 25.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
          {creepData: {type: NB.Ant, money: 120, hpMod: 4.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 40,  hpMod: 3.7,  speedMod: 1.2, countMod: 3.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Creep, money: 700, hpMod: 35.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
          {creepData: {type: NB.Ant, money: 220, hpMod: 5.0,  speedMod: 3.5, countMod: 1.2, waitMod: .9}} # fast
          {creepData: {type: NB.Ant, money: 80,  hpMod: 4.7,  speedMod: 1.2, countMod: 3.5, waitMod: .1}} # swarm
          {creepData: {type: NB.Creep, money: 1000, hpMod: 55.0, speedMod: 0.8, countMod: 0.1, waitMod: 1}} # boss
        ]
        map: new NB.Map({path: new NB.Path([
          [13,1]
          [12,1 ]
          [12,2 ]
          [11,2 ]
          [11,3 ]
          [10,3 ]
          [10,4 ]
          [9,4  ]
          [9,5  ]
          [8,5  ]
          [8,6  ]
          [7,6  ]
          [7,7  ]
          [6,7  ]
          [6,8  ]
          [5,8  ]
          [5,9  ]
          [4,9  ]
          [4,10 ]
          [3,10 ]
          [3,11 ]
          [2,11 ]
          [2,12 ]
          [1,12 ]
          [1,14 ]
          [4,14 ]
          [4,13 ]
          [6,13 ]
          [6,12 ]
          [8,12 ]
          [8,11 ]
          [10,11]
          [10,10]
          [12,10]
          [12,9 ]
          [13,9 ]
        ])})
        tree: new NB.Tree(500, [13, 9])
      })
    }
}
