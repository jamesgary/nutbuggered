NB.SumoTower::draw = (ctx) ->
  @drawRange(ctx)

  size = 64
  dim = 32
  offset = (size - dim) / 2
  x = (@coordinates[0] * dim) + offset
  y = (@coordinates[1] * dim) + offset

  # perform squirrel doing shiko (foot stomp)
  maxAngle = 70

  # qx is -.5 to .5
  qx = -.5 + (@ticksUntilAttack / @cooldown)
  a = (-maxAngle) / Math.pow(.5, 2)
  qy = (a * (Math.pow(qx,2))) + maxAngle

  rotation = @shikoRotationDirection * (qy)
  rotationRadians = rotation * Math.PI / 180

  legDistY = 15
  legDistX = legDistY * @shikoRotationDirection
  ctx.save()
  ctx.translate(x + legDistX, y + legDistY)
  ctx.rotate(rotationRadians)
  ctx.drawImage(NB.imageData.sumo, (-2 * offset) - legDistX, (-2 * offset) - legDistY)
  ctx.restore()


NB.SumoTower::drawAttack = ->
  @shikoRotationDirection = - @shikoRotationDirection
  #rotateSide = if Math.random() > .5 then 1 else -1
  #@punchRotationDirection = rotateSide
