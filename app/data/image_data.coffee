NB.imageData = {
  loadAll: ->
    @boxer = new Image
    @boxer.src = "img/towers/boxer.png?#{new Date().getTime()}"
    @slingshot = new Image
    @slingshot.src = "img/towers/slingshot.png?#{new Date().getTime()}"
    @sumo = new Image
    @sumo.src = "img/towers/sumo.png?#{new Date().getTime()}"
    @chilly = new Image
    @chilly.src = "img/towers/chilly.png?#{new Date().getTime()}"
    @bazooka = new Image
    @bazooka.src = "img/towers/bazooka.png?#{new Date().getTime()}"

    @swatter = new Image
    @swatter.src = "img/swatter.png?#{new Date().getTime()}"
    @swatterHit = new Image
    @swatterHit.src = "img/swatter-hit.png?#{new Date().getTime()}"

    @grass = new Image
    @grass.src = "img/grass.png?#{new Date().getTime()}"
    @path = new Image
    @path.src = "img/path.png?#{new Date().getTime()}"
    @spawner = new Image
    @spawner.src = "img/spawner.png?#{new Date().getTime()}"
    @snow = new Image
    @snow.src = "img/snow.png?#{new Date().getTime()}"

    @tree = new Image
    @tree.src = "img/tree/tree.png?#{new Date().getTime()}"
    @tree_dmg1 = new Image
    @tree_dmg1.src = "img/tree/tree-dmg1.png?#{new Date().getTime()}"
    @tree_dmg2 = new Image
    @tree_dmg2.src = "img/tree/tree-dmg2.png?#{new Date().getTime()}"
    @tree_dmg3 = new Image
    @tree_dmg3.src = "img/tree/tree-dmg3.png?#{new Date().getTime()}"

    @loaded = true
}
