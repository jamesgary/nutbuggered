#NB.Creep.prototype.drawInit = ->
#  canvas = document.createElement('canvas')
#  canvas.setAttribute('id','action')
#  canvas.width = 640
#  canvas.height = 640
#  NB.mainElement.appendChild(canvas)
#  ctx = canvas.getContext("2d")
#
#  dim = 32
#  grass = new Image
#  path_img = new Image
#  my_path = @path
#  window.p = @path
#  grass.onload = ->
#    for x in [0...@width]
#      for y in [0...@height]
#        if my_path.contains([x,y])
#          ctx.drawImage(path_img, x * dim, y * dim)
#        else
#          ctx.drawImage(grass, x * dim, y * dim)
#
#  grass.src = "img/grass.png?#{new Date().getTime()}"
#  path_img.src = "img/path.png?#{new Date().getTime()}"
