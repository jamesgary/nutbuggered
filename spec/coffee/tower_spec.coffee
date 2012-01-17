describe 'Tower', ->
  beforeEach ->
    @tower = new NB.Tower
  it 'exists', ->
    expect(@tower).toNotBe undefined
