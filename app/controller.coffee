NB.Controller = class Controller
  constructor: ->
    @loadAll()

  loadAll: ->
    console.log('loaded!')

    @uponClick('send_wave', -> NB.Director.sendWave()

  # private

  uponClick: (elementId, event) ->
    document.getElementById(elementId).addEventListener('click', event)
