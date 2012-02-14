NB.Map.prototype.drawInit = ->
  canvas = document.getElementById('background')
  ctx = canvas.getContext("2d")

  dim = 32
  grass = new Image
  path_img = new Image
  boxer_img = new Image
  path = @path
  map = this
  grass.onload = ->
    for x in [0...map.width]
      for y in [0...map.height]
        xPos = x * dim
        yPos = y * dim
        if path.contains([x,y])
          ctx.drawImage(path_img, xPos, yPos)
        else
          ctx.drawImage(grass, xPos, yPos)

  grass.src = "img/grass.png?#{new Date().getTime()}"
  path_img.src = "img/path.png?#{new Date().getTime()}"

NB.Map.prototype.draw = ->
  canvas = document.getElementById('foreground')
  ctx = canvas.getContext("2d")
  tower.draw(ctx) for tower in @towers
