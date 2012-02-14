NB.imageData = {
  loadAll: ->
    @boxer = new Image
    @boxer.src = "img/towers/boxer.png?#{new Date().getTime()}"
    @grass = new Image
    @grass.src = "img/grass.png?#{new Date().getTime()}"
    @path = new Image
    @path.src = "img/path.png?#{new Date().getTime()}"
}
