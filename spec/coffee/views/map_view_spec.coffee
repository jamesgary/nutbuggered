describe 'MapView', ->
  beforeEach ->
    @map = new NB.Map
  afterEach ->
    element = document.getElementById("main")
    element.parentNode.removeChild(element)
  it 'can draw initially', ->
    @map.drawInit()
