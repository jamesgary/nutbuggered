NB.Controller = {
  loadAll: ->
    # splash
    $('#splash_screen').on('click', '#start_from_splash', (e) -> NB.Director.startFromSplash())

    # levels
    $('#levels_screen').on('click', '.level_chooser', (e) ->
      levelName = e.currentTarget.dataset.map
      NB.Director.chooseLevel(levelName)
    )

    # game
    # # pause
    $('#game_screen').on('click', '#pause',   (e) -> NB.Director.pause())
    $('#game_screen').on('click', '#unpause', (e) -> NB.Director.unpause())

    # # close wave explainer
    $('#game_screen').on('click', '#waves .close, #waves .wave', (e) -> $('#explainer').fadeOut(100))

    # # sending waves
    $('#game_screen').on('click', '#waves li.wave', (e) -> NB.Director.sendWave(parseInt(e.currentTarget.dataset.wave_index)))

    # # choosing towers
    $('#game_screen').on('click', '.tower_chooser', (e) ->
      tower_type = NB[e.currentTarget.dataset.tower_type_placeholder]
      cost = NB.towerData[e.currentTarget.dataset.tower_type]().cost
      NB.Director.clickTowerChooser(tower_type, cost)
    )
    # # placing towers
    $('#game_screen').on('mousemove', '#map', (e) ->
      x = parseInt(e.offsetX / 32)
      y = parseInt(e.offsetY / 32)
      NB.Director.mapHover([x,y])
    )
    $('#game_screen').on('mouseleave', '#map', (e) -> NB.Director.movedOutOfMap())
    $('#game_screen').on('click', '#map', (e) ->
      x = parseInt(e.offsetX / 32)
      y = parseInt(e.offsetY / 32)
      NB.Director.mapClick([x, y])
    )
    $('#game_screen').on('mousemove', '#dpad', (e) ->
      dpadImgSize = 250
      dpadOffset = dpadImgSize / 2
      dpadStyle = e.target.style
      dpadCenterX = (dpadOffset + parseInt(dpadStyle.backgroundPositionX))
      dpadCenterY = (dpadOffset + parseInt(dpadStyle.backgroundPositionY))
      mouseX = e.offsetX
      mouseY = e.offsetY
      xDiff = dpadCenterX - mouseX
      yDiff = dpadCenterY - mouseY

      if yDiff > Math.abs(xDiff)
        dir = 'n'
      else if Math.abs(yDiff) > Math.abs(xDiff)
        dir = 's'
      else
        dir = if xDiff > 0 then 'w' else 'e'

      NB.Director.turnPlaceholderTower(dir)
    )
    $('#game_screen').on('click', '#dpad', (e) ->
      NB.Director.setPlaceholderTower()
      e.stopPropagation()
    )

    # # context menus
    $('#game_screen').on('click', '.return_to_levels', (e) -> NB.Director.returnToLevels())

    $('#game_screen').on('mousemove', '#map', (e) ->
      x = parseInt(e.offsetX / 32)
      y = parseInt(e.offsetY / 32)
      NB.Director.mapHover([x,y])
    )
    $('#game_screen').on('mousemove', '#map', (e) ->
      x = parseInt(e.offsetX / 32)
      y = parseInt(e.offsetY / 32)
      NB.Director.level.erase([e.offsetX,e.offsetY])
    )
}
