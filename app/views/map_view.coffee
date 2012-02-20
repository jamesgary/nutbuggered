NB.Map.prototype.drawInit = ->
  if NB.imageData.loaded
    canvas = document.getElementById('background')
    ctx = canvas.getContext("2d")
    dim = 32

    startX = @path.start()[0]
    startY = @path.start()[1]
    for x in [0...@width]
      for y in [0...@height]
        if x == startX && y == startY
          image = NB.imageData.spawner
        else
          if @path.contains([x,y])
            image = NB.imageData.path
          else
            image = NB.imageData.grass
        xPos = x * dim
        yPos = y * dim
        ctx.drawImage(image, xPos, yPos)

NB.Map.prototype.draw = ->
  canvas = document.getElementById('foreground')
  ctx = canvas.getContext("2d")
  tower.draw(ctx) for tower in @towers
