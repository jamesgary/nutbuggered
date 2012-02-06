describe 'MapView', ->
  beforeEach ->
    @map = new NB.Map
  afterEach ->
    element = document.getElementById("main")
    element.parentNode.removeChild(element)
  xit 'can draw initially', ->
    @map.drawInit()
