describe 'Grid', ->
  # set X and O for readability
  # not in a beforeEach so we don't have to use @X and @O
  X = true
  O = false
  describe 'when freshly constructed', ->
    beforeEach ->
      @g = new NB.Grid
    it 'should have a default length of 10', ->
      expect(@g.length).toEqual 10
    it 'should have a default width of 10', ->
      expect(@g.width).toEqual 10
    describe 'when given length and width parameters', ->
      beforeEach ->
        @custom_length = 4
        @custom_width = 2
        @g = new NB.Grid @custom_width, @custom_length
      it 'should have custom length', ->
        expect(@g.length).toEqual @custom_length
      it 'should have custom width', ->
        expect(@g.width).toEqual @custom_width
      it 'should have a "visually rectangular" 2d array of cells', ->
        expect(@g.cells).toEqual [[O, O],
                                  [O, O],
                                  [O, O],
                                  [O, O]]
    describe '.cellAt', ->
      it 'should contain "dead cells"', ->
        expect(@g.cellAt(0,0)).toEqual O
        expect(@g.cellAt(9,9)).toEqual O
  describe 'after some generations', ->
    beforeEach ->
      @g = new NB.Grid 3, 3 # smaller grid for more managable test cases
    describe 'Rule 0: Any dead cell without exactly three live neighbors remains dead', ->
      describe 'with a grid of a dead cells', ->
        it 'should remain a grid of dead cells', ->
          @g.generate()
          expect(@g.cells).toEqual [[O, O, O],
                                    [O, O, O],
                                    [O, O, O]]
    describe 'Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.', ->
      describe 'with a live cell in the center', ->
        beforeEach ->
          @g.cells = [[O, O, O],
                      [O, X, O],
                      [O, O, O]]
        it 'should kill that cell', ->
          @g.generate()
          expect(@g.cells).toEqual [[O, O, O],
                                    [O, O, O],
                                    [O, O, O]]
      # for full test coverage, also test other 3 corners?
      describe 'with one cell in the corner', ->
        beforeEach ->
          @g.cells = [[X, O, O],
                      [O, O, O],
                      [O, O, O]]
        it 'should kill that cell', ->
          @g.generate()
          expect(@g.cells).toEqual [[O, O, O],
                                    [O, O, O],
                                    [O, O, O]]
      # TODO: Sides too
    describe 'Rule 2: Any live cell with two or three live neighbours lives on to the next generation.', ->
      describe 'with a live cell in the center with 2 live neighbors', ->
        beforeEach ->
          @g.cells = [[X, X, O],
                      [O, X, O],
                      [O, O, O]]
        it 'should keep that cell alive', ->
          @g.generate()
          expect(@g.cellAt(1,1)).toBe(X)
      describe 'with a live cell in the center with 3 live neighbors', ->
        beforeEach ->
          @g.cells = [[X, X, O],
                      [O, X, O],
                      [O, O, X]]
        it 'should keep that cell alive', ->
          @g.generate()
          expect(@g.cellAt(1,1)).toBe(X)
    describe 'Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding.', ->
      describe 'with a live cell in center with 4 live neighbors', ->
        beforeEach ->
          @g.cells = [[X, X, O],
                      [O, X, O],
                      [X, O, X]]
        it 'should make that cell dead', ->
          @g.generate()
          expect(@g.cellAt(1,1)).toBe(O)
    describe 'Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.', ->
      describe 'with a dead cell in the center with 3 live neighbors', ->
        beforeEach ->
          @g.cells = [[X, X, O],
                      [O, O, O],
                      [O, O, X]]
        it 'should make that cell alive', ->
          @g.generate()
          expect(@g.cellAt(1,1)).toBe(X)
  describe 'smoke test', ->
    it 'should perform a couple tall "glider" generations', ->
      @g = new NB.Grid 3, 4
      @g.cells = [[O, X, O],
                  [O, O, X],
                  [X, X, X],
                  [O, O, O]]
      @g.generate()
      expect(@g.cells).toEqual [[O, O, O],
                                [X, O, X],
                                [O, X, X],
                                [O, X, O]]
      @g.generate()
      expect(@g.cells).toEqual [[O, O, O],
                                [O, O, X],
                                [X, O, X],
                                [O, X, X]]
    it 'should perform a couple wide "glider" generations', ->
      @g = new NB.Grid 4, 3
      @g.cells = [[O, O, X, O],
                  [X, O, X, O],
                  [O, X, X, O]]
      @g.generate()
      expect(@g.cells).toEqual [[O, X, O, O],
                                [O, O, X, X],
                                [O, X, X, O]]
      @g.generate()
      expect(@g.cells).toEqual [[O, O, X, O],
                                [O, O, O, X],
                                [O, X, X, X]]
  describe '.randomize', ->
    # don't feel like writing test, so...
    it "shouldn't break anything", ->
      g = new NB.Grid()
      g.randomize()
