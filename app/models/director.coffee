NB.Director = {
  start: ->
    @stage = new NB.Stage()
    @tick()
  tick: ->
    webkitRequestAnimationFrame(NB.Director.tick)
    NB.Director.stage.tick()
    NB.Director.stage.draw()
  placeTower: (tower, coordinates) ->
    @level.placeTower(tower, coordinates)
  canPlaceTower: (tower, coordinates) ->
    @level.canPlaceTower(tower, coordinates)
  endGame: (won) ->
    unless @hasEnded
      if won
        $('#victory_dialogue').fadeIn 200
        console.log('A winner is you!')
      else
        @hasEnded = true
        $('#defeat_dialogue').fadeIn 200
        console.log('A loser is you!')
  startLevel: (levelData) ->
    @hasEnded = false
    @level = levelData.level
    @stage.load(@level)

  # from the controller

  sendWave: (index) ->
    @level.sendWave(index)
  startFromSplash: ->
    $('#levels_screen').fadeIn 200, ->
      $('#splash_screen').hide()
  chooseLevel: (levelName) ->
    level = NB.levelData[levelName]()
    @startLevel(level)
    $('#victory_dialogue').hide()
    $('#defeat_dialogue').hide()
    $('#game_screen').fadeIn 200, ->
      $('#levels_screen').hide()
  returnToLevels: () ->
    @level = null
    @stage.clear()
    $('#levels_screen').fadeIn 200, ->
      $('#game_screen').hide()
  mapHover: (coordinates) ->
    if @placeholderTower && @placeholderTower.hovering && @canPlaceTower(@placeholderTower, coordinates)
      if @placeholderTower.coordinates # need to replace it
        @level.removeTower(@placeholderTower)
      @placeholderTower.coordinates = coordinates
      @placeTower(@placeholderTower, coordinates)
  mapClick: (coordinates) ->
    @placeholderTower.hovering = false if @placeholderTower
  clickTowerChooser: (towerType) ->
    @placeholderTower = new towerType()
  turnPlaceholderTower: (dir) ->
    if @placeholderTower
      @placeholderTower.direction = dir
  setPlaceholderTower: ->
    realTower = @placeholderTower.promote()
    @level.removeTower(@placeholderTower)
    @placeTower(realTower, realTower.coordinates)
    $('#dpad').hide()
    @placeholderTower = null
  movedOutOfMap: ->
    if @placeholderTower
      console.log('getout!')
      $('#dpad').hide()
      @level.removeTower(@placeholderTower)
      @placeholderTower = null
}
