NB.ViewHelper = {
  drawHealth: (opts) ->
    ctx = opts.ctx
    x = opts.x
    y = opts.y
    hpBarWidth = opts.width
    hpBarHeight = opts.height
    hp = opts.hp
    maxHp = opts.maxHp

    border = 1

    #border
    ctx.fillStyle = "#000000"
    ctx.fillRect(
      x - border,
      y - border,
      hpBarWidth + (2 * border),
      hpBarHeight + (2 * border)
    )
    #health
    ctx.fillStyle = "#00ff00"
    ctx.fillRect(x, y, hpBarWidth, hpBarHeight)
    #damage
    if (hp < maxHp)
      ctx.fillStyle = "#ff0000"
      ctx.fillRect(x, y, ((maxHp - hp) / maxHp) * hpBarWidth, hpBarHeight)

  pixelateImage: (image, canvas) ->
    console.log(canvas)
    context = canvas.getContext('2d')

    # Create an offscreen canvas, draw an image to it, and fetch the pixels
    offtx = document.createElement('canvas').getContext('2d')
    console.log(image)
    offtx.drawImage(image,0,0)
    console.log(image.width)
    console.log(image.height)
    imgData = offtx.getImageData(0,0,image.width,image.height).data

    # Draw the zoomed-up pixels to a different canvas context
    for x in [0..image.width]
      for y in [0..image.height]
        console.log([x,y])
        # Find the starting index in the one-dimensional image data
        i = (y*image.width + x)*4
        r = imgData[i  ]
        g = imgData[i+1]
        b = imgData[i+2]
        a = imgData[i+3]
        ctx.fillStyle = "rgba("+r+","+g+","+b+","+(a/255)+")"
        ctx.fillRect(x*zoom,y*zoom,zoom,zoom)
}
