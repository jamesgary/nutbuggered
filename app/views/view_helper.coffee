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
}
