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

    # # speed
    $('#game_screen').on('click', '#speed1',   (e) -> NB.Director.setGameSpeed(1))
    $('#game_screen').on('click', '#speed2',   (e) -> NB.Director.setGameSpeed(2))
    $('#game_screen').on('click', '#speed4',   (e) -> NB.Director.setGameSpeed(4))

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
    $('#game_screen').on('mouseover', '.tower_chooser, .swatter', (e) ->
      if NB.Director.activeTower
        NB.Director.activeTower.unclick()
        NB.Director.activeTower = null
      tower_name = e.currentTarget.dataset.name
      $("#infospace #tower_descriptions > div").hide()
      $("#infospace #tower_descriptions .#{tower_name}").show()
      $("#infospace #tower_descriptions").show()
    )

    $('#game_screen').on('click', '.swatter', (e) ->
      NB.Director.clickSwatter()
    )
    # # placing towers
    $('#game_screen').on('mousemove', '#map', (e) ->
      x = NB.Director.currentX = e.offsetX
      y = NB.Director.currentY = e.offsetY
      if NB.Director.level.swatter
        NB.Director.mapHoverWithSwatter([x,y])
      else
        x = parseInt(x / 32)
        y = parseInt(y / 32)
        NB.Director.mapHover([x,y])
    )
    $('#game_screen').on('mouseleave', '#map', (e) -> NB.Director.movedOutOfMap())
    $('#game_screen').on('mousedown', '#map', (e) ->
      $("#infospace #tower_descriptions").hide()
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

    # # hotkeys
    $('body').keypress((e) ->
      NB.Director.movedOutOfMap()
      key = String.fromCharCode(e.which)
      switch key
        when 'a' then $('.tower_chooser.boxer').click()
        when 's' then $('.tower_chooser.slingshot').click()
        when 'd' then $('.tower_chooser.sumo').click()
        when 'f' then $('.tower_chooser.chilly').click()
        when 'g' then $('.swatter').click()
        when 'b' then $('.tower_chooser.bazooka').click()
        when ' ' then [NB.Director.level.sendNextWave(),  $('#explainer').fadeOut(100)]
        when '`' then NB.Director.pause()
        when '1' then NB.Director.setGameSpeed(1)
        when '2' then NB.Director.setGameSpeed(2)
        when '3' then NB.Director.setGameSpeed(4)

      #FIXME DRY
      x = NB.Director.currentX
      y = NB.Director.currentY
      if (x && y)
        if NB.Director.level.swatter
          NB.Director.mapHoverWithSwatter([x,y])
        else
          x = parseInt(x / 32)
          y = parseInt(y / 32)
          NB.Director.mapHover([x,y])

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
