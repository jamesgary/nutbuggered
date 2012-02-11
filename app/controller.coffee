NB.Controller = {
  loadAll: ->
    @uponClick('send_wave', -> NB.Director.sendWave())
    @uponClick('map', (e) ->
      x = parseInt(e.offsetX / 32)
      y = parseInt(e.offsetY / 32)
      NB.Director.placeTower(new NB.BoxerTower([x, y], 's'), [x,y])
    )

  # private

  uponClick: (elementId, event) ->
    document.getElementById(elementId).addEventListener('click', event)
}
