describe 'Tower', ->
  beforeEach ->
    @tower = new NB.Tower
  it 'exists', ->
    expect(@tower).toNotBe undefined
  it 'costs 100', ->
    expect(@tower.cost).toEqual 100
