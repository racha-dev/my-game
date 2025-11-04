function love.load()
    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")


    player = {}
    player.x = 200
    player.y = 200
    player.speed = 7
    player.spriteSheet = love.graphics.newImage('sprites/def-player.png')
    player.grid = anim8.newGrid( 32, 32, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )
    player.face = "right"

    player.animations = {}
    player.animations.down = anim8.newAnimation( player.grid('1-4', 1), 0.2 )
    player.animations.left = anim8.newAnimation( player.grid('1-4', 2), 0.2 )
    player.animations.right = anim8.newAnimation( player.grid('1-4', 3), 0.2 )
    player.animations.up = anim8.newAnimation( player.grid('1-4', 4), 0.2 )
    player.animations.down.idle = anim8.newAnimation( player.grid('1-4', 5), 0.4 )
    player.animations.left.idle = anim8.newAnimation( player.grid('1-4', 6), 0.4 )
    player.animations.right.idle = anim8.newAnimation( player.grid('1-4', 7), 0.4 )
    player.animations.up.idle = anim8.newAnimation( player.grid('1-4', 8), 0.4 )
   
    
    player.anim = player.animations

    background = love.graphics.newImage('sprites/bg.png')
end

function love.update(dt)
    local isMoving = false
    
    --movimentação e animações de movimento
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        isMoving = true
        --player.face define a direção que o player passa a olhar quando a tecla direcional é pressionada
        player.face = "right"
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        isMoving = true
        player.face = "left"
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animations.down
        isMoving = true
        player.face = "down"
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animations.up
        isMoving = true
        player.face = "up"
    end

    --programação da animação de idle
    --estado neutro da animação
    if isMoving == false then
        player.anim = player.animations.down.idle
    end
    --animação se o player.face for alterado(ele sempre vai estar alterado)
    if player.face == "down" and isMoving == false then
        player.anim = player.animations.down.idle
    elseif player.face == "right" and isMoving == false then
        player.anim = player.animations.right.idle
    elseif player.face == "left" and isMoving == false then
        player.anim = player.animations.left.idle
    elseif player.face == "up" and isMoving == false then
        player.anim = player.animations.up.idle
    end
    --define para que tudo isso continue sendo atualizado por todos os frames
    player.anim:update(dt)
   
end

function love.draw()
    love.graphics.draw(background, 0, 0, nil, 100)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 5)
end
