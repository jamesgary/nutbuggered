NB.Controller = {
  loadAll: ->
    # splash
    @uponClick('start_from_splash', -> NB.Director.startFromSplash())

    # levels
    $('#levels_screen').on('click', '.level_chooser', (e) ->
      levelName = e.toElement.dataset.map
      NB.Director.chooseLevel(levelName)
    )

    # game
    # # sending waves
    $('#game_screen').on('click', 'ul#waves li.wave', (e) -> NB.Director.sendWave(parseInt(e.toElement.dataset.wave_index)))

    # # choosing towers
    $('#game_screen').on('click', '.tower_chooser', (e) -> 
      NB.Director.clickTowerChooser(NB[e.toElement.dataset.tower_type]))

    # # placing towers
    $('#game_screen').on('mousemove', '#map', (e) ->
      x = parseInt(e.offsetX / 32)
      y = parseInt(e.offsetY / 32)
      NB.Director.mapHover([x,y])
    )
    $('#game_screen').on('mouseleave', '#map', (e) -> NB.Director.movedOutOfMap())
    @uponClick('foreground', (e) ->
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
      #console.log([dpadCenterX, dpadCenterY])
      #console.log [mouseX, mouseY]
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
    @uponClick('dpad', -> NB.Director.setPlaceholderTower())

    # # context menus
    $('#game_screen').on('click', '.return_to_levels', (e) -> NB.Director.returnToLevels())

  # private

  uponClick: (elementId, event) ->
    document.getElementById(elementId).addEventListener('click', event)
}
