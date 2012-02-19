NB.SlingshotTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  # draw squirrel
  ctx.save()

  # look at a creep
  ctx.translate(x, y)
  ctx.rotate(@aimingAngle) if @aimingAngle
  ctx.drawImage(NB.imageData.slingshot, -2 * offset, -2 * offset)
  ctx.restore()

  # draw projectile
  projectile.draw(ctx) for projectile in @projectiles

NB.SlingshotTower.prototype.drawAttack = (creep) ->
  ctx = NB.Director.level.ctx
  if creep
    size = 64
    dim = 32
    offset = (size - dim) / 2
    x = (@coordinates[0] * dim) + offset
    y = (@coordinates[1] * dim) + offset

    rotateSide = if Math.random() > .5 then 1 else -1
    rotation = Math.atan2(
      creep.position[1] - @coordinates[1],
      creep.position[0] - @coordinates[0],
    ) - (90 * Math.PI / 180)

    @aimingAngle = rotation
    @targetCoordinates = creep.position

    origin = [
      (@coordinates[0] * dim) + offset + 8,
      (@coordinates[1] * dim) + offset,
    ]
    target = [
      (@targetCoordinates[0] * dim) + offset,
      (@targetCoordinates[1] * dim) + offset,
    ]

    console.log(@projectiles)
    @projectiles.push(new NB.Projectile(origin, target))

    @projectiles = @projectiles.filter(NB.Projectile.removeOldFilter)

NB.Projectile = class Projectile
  constructor: (@origin, @target) ->
    @age = 0
    @lifespan = 15
  draw: (ctx) ->
    ctx.lineWidth = 5
    ctx.lineCap = 'round'
    ctx.beginPath()
    lineargradient = ctx.createLinearGradient(
      @origin[0], @origin[1],
      @target[0], @target[1]
    )

    transparencyMod = 1 - (@age / @lifespan)
    lineargradient.addColorStop(.2, "rgba(255,255,255,#{.2 * transparencyMod})")
    lineargradient.addColorStop(1,  "rgba(200,200,200,#{1 * transparencyMod})")
    ctx.strokeStyle = lineargradient

    ctx.moveTo(@origin[0], @origin[1])
    ctx.lineTo(@target[0], @target[1])
    ctx.stroke()
    @age++
    @dead = @age >= @lifespan
NB.Projectile.lifespan = 15
NB.Projectile.removeOldFilter = (element, index, array) ->
  !element.dead
