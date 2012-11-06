window.requestAnimFrame = ((callback) ->
    return window.requestAnimationFrame   || 
    window.webkitRequestAnimationFrame    || 
    window.mozRequestAnimationFrame       || 
    window.oRequestAnimationFrame         || 
    window.msRequestAnimationFrame        ||
    (callback) ->
        window.setTimeout callback, 1000 / 60
)()

controls =
    37: 'left'
    38: 'up'
    39: 'right'
    40: 'down'

commands = 
    left: false
    up: false
    right: false
    down: false

car =
    x: 320
    y: 410
    rotation: 0
    speed: 0
    img: null

car.img = new Image();
car.img.src = 'img/car.png'

cnv = null
ctx = null

drawImg = (img, x, y, rot) ->
    ctx.save()
    ctx.translate x, y
    ctx.rotate rot
    ctx.drawImage img, -(img.width/2), -(img.height/2)
    ctx.restore()

run = ->
    if commands.up
        car.speed += 0.1 if car.speed < 6
    else if commands.down
        car.speed -= 0.1 if car.speed > -3
    else
        if car.speed > 0 then car.speed -= 0.1 else car.speed += 0.1

    car.rotation += car.speed / 90 if commands.right
    car.rotation -= car.speed / 90 if commands.left

    car.y += Math.sin(car.rotation) * car.speed
    car.x += Math.cos(car.rotation) * car.speed

    ctx.clearRect(0, 0, 640, 480)

    drawImg car.img, car.x, car.y, car.rotation

    requestAnimFrame ->
        run cnv, ctx

init = ->
    cnv = document.getElementById 'game-canvas'
    ctx = cnv.getContext '2d'
    run()

$(document).ready ->
    init()

    $(window).bind 'keydown keyup', (e) ->
        if controls.hasOwnProperty e.keyCode
            commands[controls[e.keyCode]] = e.type == 'keydown'

