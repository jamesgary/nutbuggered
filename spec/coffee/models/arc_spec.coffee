describe 'Arc', ->
  describe 'horizontal arc', ->
    beforeEach ->
      @arc = new NB.Arc([3,1], [0,1])
    describe '#contains', ->
      it 'can tell if a point is on its arc', ->
        expect(@arc.contains([3,1])).toBeTruthy()
        expect(@arc.contains([2,1])).toBeTruthy()
        expect(@arc.contains([1,1])).toBeTruthy()
        expect(@arc.contains([0,1])).toBeTruthy()
      it 'can tell if a point is not on its arc', ->
        expect(@arc.contains([2,3])).toBeFalsy()
        expect(@arc.contains([4,1])).toBeFalsy()
    describe '#travel', ->
      it 'returns the coordinate traveled a distance on its arc', ->
        expect(@arc.travel([2,1], 1)).toEqual [1,1]
      it 'returns excess distance if distance surpasses finish', ->
        expect(@arc.travel([2,1], 5)).toEqual 3
    describe '#distanceTraveledFor', -> # obsolete?
      it 'returns distance traveled for given coordinate', ->
        expect(@arc.distanceTraveledFor([2, 1])).toEqual 1
  describe 'vertical arc', ->
    beforeEach ->
      @arc = new NB.Arc([1,1], [1,5])
    describe '#contains', ->
      it 'can tell if a point is on its arc', ->
        expect(@arc.contains([1,3])).toBeTruthy()
      it 'can tell if a point is not on its arc', ->
        expect(@arc.contains([2,3])).toBeFalsy()
        expect(@arc.contains([1,6])).toBeFalsy()
    describe '#travel', ->
      it 'returns the coordinate traveled a distance on its arc', ->
        expect(@arc.travel([1,2], 2)).toEqual [1,4]
      it 'returns excess distance if distance surpasses finish', ->
        expect(@arc.travel([1,2], 7)).toEqual 4
    describe '#distanceTraveledFor', -> # obsolete?
      it 'returns distance traveled for given coordinate', ->
        expect(@arc.distanceTraveledFor([1, 4])).toEqual 3
