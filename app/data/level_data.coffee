NB.levelData = {
  level1: ->
    {
      level: new NB.Level({
        wavesData: [
          {creepData: {type: NB.Creep, hpMod: 1, speedMod: 1, countMod: 1, waitMod: .3}}
          {creepData: {type: NB.Creep, hpMod: 1.2, speedMod: 1.2, countMod: .8, waitMod: .2}}
          {creepData: {type: NB.Creep, hpMod: 2.5, speedMod: 11.5, countMod: 2.5, waitMod: .1}}
        ]
        map: new NB.Map(new NB.Path([[7,7], [7,5], [2,5], [2, 10], [13, 10]]))
        tree: new NB.Tree(1000)
      })
    }
}
