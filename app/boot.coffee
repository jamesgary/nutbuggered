require ["js/compiled/grid.js", "js/compiled/simple_canvas.js"], ->
  console.log("* All loaded, sir!")
  sc = new SimpleCanvas(new Grid(600, 400))
  console.log("* All done, sir!")
