NB.Map.prototype.drawInit = ->
  if NB.imageData.loaded
    canvas = document.getElementById('background')
    ctx = canvas.getContext("2d")
    dim = 32

    for x in [0...@width]
      for y in [0...@height]
        xPos = x * dim
        yPos = y * dim
        if @path.contains([x,y])
          ctx.drawImage(NB.imageData.path, xPos, yPos)
        else
          ctx.drawImage(NB.imageData.grass, xPos, yPos)

NB.Map.prototype.draw = ->
  canvas = document.getElementById('foreground')
  ctx = canvas.getContext("2d")
  tower.draw(ctx) for tower in @towers
