describe 'Map', ->
  beforeEach ->
    @map = new NB.Map
  it 'exists', ->
    expect(@map).toNotBe undefined
