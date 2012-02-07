NB.Controller = class Controller
  constructor: ->
    @loadAll()

  loadAll: ->
    @uponClick('send_wave', -> NB.Director.sendWave())

  # private

  uponClick: (elementId, event) ->
    document.getElementById(elementId).addEventListener('click', event)
