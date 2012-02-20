NB.Director = {
  start: ->
    @stage = new NB.Stage()
    @tick()
  tick: ->
    webkitRequestAnimationFrame(NB.Director.tick)
    unless NB.Director.paused
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
    @unpause()
    @hasEnded = false
    @level = levelData.level
    @stage.load(@level)

  # from the controller

  pause: -> # can be called by pokki hook
    NB.Director.paused = true
    $('#pause_dialogue').show()
  unpause: ->
    @paused = false
    $('#pause_dialogue').hide()
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

    # set tower costs
    $('#buttons a.tower_chooser').each((index) ->
      $this = $(this)
      dataset = this.dataset
      if tower_type = dataset.tower_type
        cost = (new NB.towerData[tower_type]()).cost
        $this.find('.cost').text(cost)
    )

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
      @placeholderTower.refreshRange()
      @placeTower(@placeholderTower, coordinates)
  mapClick: (coordinates) ->
    @placeholderTower.hovering = false if @placeholderTower
    tower = @level.map.cellAt(coordinates[0], coordinates[1])
    if tower
      @activeTower.unclick() if @activeTower
      @activeTower = tower
      tower.clicked()
    else
      if @activeTower
        @activeTower.unclick()
        @activeTower = null
  clickTowerChooser: (towerType, cost) ->
    console.log("cost: #{cost} and i have #{@level.money}")
    if cost <= @level.money
      @activeTower.unclick() if @activeTower
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
    @mapClick(realTower.coordinates)
  movedOutOfMap: ->
    if @placeholderTower
      $('#dpad').hide()
      @level.removeTower(@placeholderTower)
      @placeholderTower = null
}
