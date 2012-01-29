NB.Map.prototype.draw = ->
  canvas = document.getElementById('main')
  canvas.width = 800
  canvas.height = 640
  ctx = canvas.getContext("2d")

  dim = 32
  grass = new Image
  grass.onload = ->
    for x in [0...@width]
      for y in [0...@height]
        ctx.drawImage(grass, x * dim, y * dim)

  grass.src = "grass.png?#{new Date().getTime()}"
