(function() {

  describe('Grid', function() {
    var O, X;
    X = true;
    O = false;
    describe('when freshly constructed', function() {
      beforeEach(function() {
        return this.g = new Grid;
      });
      it('should have a default length of 10', function() {
        return expect(this.g.length).toEqual(10);
      });
      it('should have a default width of 10', function() {
        return expect(this.g.width).toEqual(10);
      });
      describe('when given length and width parameters', function() {
        beforeEach(function() {
          this.custom_length = 4;
          this.custom_width = 2;
          return this.g = new Grid(this.custom_width, this.custom_length);
        });
        it('should have custom length', function() {
          return expect(this.g.length).toEqual(this.custom_length);
        });
        it('should have custom width', function() {
          return expect(this.g.width).toEqual(this.custom_width);
        });
        return it('should have a "visually rectangular" 2d array of cells', function() {
          return expect(this.g.cells).toEqual([[O, O], [O, O], [O, O], [O, O]]);
        });
      });
      return describe('.cellAt', function() {
        return it('should contain "dead cells"', function() {
          expect(this.g.cellAt(0, 0)).toEqual(O);
          return expect(this.g.cellAt(9, 9)).toEqual(O);
        });
      });
    });
    describe('after some generations', function() {
      beforeEach(function() {
        return this.g = new Grid(3, 3);
      });
      describe('Rule 0: Any dead cell without exactly three live neighbors remains dead', function() {
        return describe('with a grid of a dead cells', function() {
          return it('should remain a grid of dead cells', function() {
            this.g.generate();
            return expect(this.g.cells).toEqual([[O, O, O], [O, O, O], [O, O, O]]);
          });
        });
      });
      describe('Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.', function() {
        describe('with a live cell in the center', function() {
          beforeEach(function() {
            return this.g.cells = [[O, O, O], [O, X, O], [O, O, O]];
          });
          return it('should kill that cell', function() {
            this.g.generate();
            return expect(this.g.cells).toEqual([[O, O, O], [O, O, O], [O, O, O]]);
          });
        });
        return describe('with one cell in the corner', function() {
          beforeEach(function() {
            return this.g.cells = [[X, O, O], [O, O, O], [O, O, O]];
          });
          return it('should kill that cell', function() {
            this.g.generate();
            return expect(this.g.cells).toEqual([[O, O, O], [O, O, O], [O, O, O]]);
          });
        });
      });
      describe('Rule 2: Any live cell with two or three live neighbours lives on to the next generation.', function() {
        describe('with a live cell in the center with 2 live neighbors', function() {
          beforeEach(function() {
            return this.g.cells = [[X, X, O], [O, X, O], [O, O, O]];
          });
          return it('should keep that cell alive', function() {
            this.g.generate();
            return expect(this.g.cellAt(1, 1)).toBe(X);
          });
        });
        return describe('with a live cell in the center with 3 live neighbors', function() {
          beforeEach(function() {
            return this.g.cells = [[X, X, O], [O, X, O], [O, O, X]];
          });
          return it('should keep that cell alive', function() {
            this.g.generate();
            return expect(this.g.cellAt(1, 1)).toBe(X);
          });
        });
      });
      describe('Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding.', function() {
        return describe('with a live cell in center with 4 live neighbors', function() {
          beforeEach(function() {
            return this.g.cells = [[X, X, O], [O, X, O], [X, O, X]];
          });
          return it('should make that cell dead', function() {
            this.g.generate();
            return expect(this.g.cellAt(1, 1)).toBe(O);
          });
        });
      });
      return describe('Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.', function() {
        return describe('with a dead cell in the center with 3 live neighbors', function() {
          beforeEach(function() {
            return this.g.cells = [[X, X, O], [O, O, O], [O, O, X]];
          });
          return it('should make that cell alive', function() {
            this.g.generate();
            return expect(this.g.cellAt(1, 1)).toBe(X);
          });
        });
      });
    });
    describe('smoke test', function() {
      it('should perform a couple tall "glider" generations', function() {
        this.g = new Grid(3, 4);
        this.g.cells = [[O, X, O], [O, O, X], [X, X, X], [O, O, O]];
        this.g.generate();
        expect(this.g.cells).toEqual([[O, O, O], [X, O, X], [O, X, X], [O, X, O]]);
        this.g.generate();
        return expect(this.g.cells).toEqual([[O, O, O], [O, O, X], [X, O, X], [O, X, X]]);
      });
      return it('should perform a couple wide "glider" generations', function() {
        this.g = new Grid(4, 3);
        this.g.cells = [[O, O, X, O], [X, O, X, O], [O, X, X, O]];
        this.g.generate();
        expect(this.g.cells).toEqual([[O, X, O, O], [O, O, X, X], [O, X, X, O]]);
        this.g.generate();
        return expect(this.g.cells).toEqual([[O, O, X, O], [O, O, O, X], [O, X, X, X]]);
      });
    });
    return describe('.randomize', function() {
      return it("shouldn't break anything", function() {
        var g;
        g = new Grid();
        return g.randomize();
      });
    });
  });

}).call(this);
