NB.BazookaTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  # draw squirrel
  ctx.save()
  ctx.translate(x, y)
  quarterTurns = switch @direction
    when 'n' then 2
    when 'e' then 3
    when 's' then 0
    when 'w' then 1
  totalTurn = quarterTurns * 90

  rotation = (totalTurn * Math.PI / 180)
  ctx.rotate(rotation)
  ctx.drawImage(NB.imageData.bazooka, -3 * offset, -3 * offset)
  ctx.restore()
  projectile.draw(ctx) for projectile in @projectiles if @projectiles

NB.BazookaTower::drawAttack = ->
  ctx = NB.Director.level.ctx
  target =  @range[@range.length - 1]
  @projectiles.push(new NB.BazookaProjectile(
    [@coordinates[0] * 32, (@coordinates[1] * 32) + 10],
    [target[0] * 32, (target[1] * 32) + 10]
  ))
  @projectiles = @projectiles.filter(NB.Projectile.removeOldFilter)

# FIXME (3ish hours from deadline, forgive me)
NB.BazookaProjectile = class BazookaProjectile
  constructor: (@origin, @target) ->
    @age = 0
    @lifespan = 30
  draw: (ctx) ->
    ctx.lineWidth = 16
    ctx.lineCap = 'round'
    ctx.beginPath()
    lineargradient = ctx.createLinearGradient(
      @origin[0], @origin[1],
      @target[0], @target[1]
    )
    transparencyMod = 1 - (@age / @lifespan)
    lineargradient.addColorStop(.2, "rgba(255,200,200,#{.4 * transparencyMod})")
    lineargradient.addColorStop(1,  "rgba(255,10,10,#{1 * transparencyMod})")
    ctx.strokeStyle = lineargradient

    ctx.moveTo(@origin[0], @origin[1])
    ctx.lineTo(@target[0], @target[1])
    ctx.stroke()
    @age++
    @dead = @age >= @lifespan
NB.BazookaProjectile.lifespan = 30
NB.BazookaProjectile.removeOldFilter = (element, index, array) ->
  !element.dead
