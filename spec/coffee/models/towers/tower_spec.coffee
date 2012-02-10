describe 'Tower', ->
  beforeEach ->
    @coordinates = [4,2]
    @tower = new NB.Tower(@coordinates)
  it 'exists', ->
    expect(@tower).toNotBe undefined
  it 'costs 100', ->
    expect(@tower.cost).toEqual 100
  it 'has a position', ->
    expect(@tower.coordinates).toEqual [4,2]
