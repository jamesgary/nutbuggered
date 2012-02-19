NB.levelData = {
  level1: ->
    {
      level: new NB.Level({
        wavesData: [
          {creepData: {type: NB.Creep, money: 10, hpMod: 1, speedMod: 1, countMod: 1, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 15, hpMod: 1.2, speedMod: 1.2, countMod: .8, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 20, hpMod: 2.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 30, hpMod: 3.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 50, hpMod: 4.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 70, hpMod: 6.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 110, hpMod: 6.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 180, hpMod: 5.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 270, hpMod: 3.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
          {creepData: {type: NB.Creep, money: 380, hpMod: 2.5, speedMod: 11.5, countMod: 1.5, waitMod: 1}}
        ]
        map: new NB.Map(new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]]))
        tree: new NB.Tree(1000, [13, 10])
      })
    }
}
