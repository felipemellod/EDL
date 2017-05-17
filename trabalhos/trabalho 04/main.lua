-- Objetivo: "Pegar" círculos menores que o seu, até que você alcance um tamanho máximo, e assim ganhe o jogo.
-- Controles: Apenas utilizar as setas para movimentar o seu círculo para "pegar", ou fugir de, outros círculos.
-- Como ganhar/perder: Se você "pegar" um círculo maior que o seu, você perde.

local gameover = "Você perdeu"
local youwon = "Parabéns, você ganhou!"
local buttons1 = {"Try again", "OK", enterbutton=2}
local buttons2 = {"Play again", "OK", enterbutton=2}

function love.load ()
	love.graphics.setBackgroundColor (255, 255, 255)
	w = love.graphics.getWidth()
	h = love.graphics.getHeight()
	love.graphics.setColor(0, 0, 0)
    p1 = { x=50,  y=h-6, r=7 }
	love.graphics.setColor(love.math.random(1, 254), love.math.random(1, 254), love.math.random(1, 254))
    p2 = { x=50, y=0, r=6 }	
end

function love.keypressed (key)
    if key == 'left' then
        p1.x = p1.x - 5
    elseif key == 'right' then
        p1.x = p1.x + 5
    end
end

function collides (o1, o2)
    return (o1.x+o1.r >= o2.x) and (o1.x-o1.r <= o2.x) and
           (o1.y+o1.r >= o2.y) and (o1.y-o1.r <= o2.y)
end

function love.update (dt)
    p2.y = p2.y + 0.3
	if love.keyboard.isDown("left") then
		p1.x = p1.x - 0.3
	elseif love.keyboard.isDown("right") then
		p1.x = p1.x + 0.3
	end

    if collides(p1, p2) then
		if p1.r <= p2.r then
			p1.r=0
			msg1 = love.window.showMessageBox('GAME OVER', gameover, buttons1, info)
			if msg1 == 1 then
				love.event.quit('restart')
			elseif msg1 == 2 then
				love.event.quit(0)
			end
		else
			p1.r = p1.r + (p2.r/2)
			p2.r = 0
		end
		if (p2.r == 0) then
			love.graphics.setColor(love.math.random(1, 254), love.math.random(1, 254), love.math.random(1, 254))
			p2 = { x=love.math.random(0, w), y=0, r=love.math.random(3, 20) }
		end
		if (p1.r >= h/2) then
			msg2 = love.window.showMessageBox('YOU WON', youwon, buttons2, info)
			if msg2 == 1 then
				love.event.quit('restart')
			elseif msg2 == 2 then
				love.event.quit(0)
			end
		end
    end
	
	if (p2.y > h) then
		love.graphics.setColor(love.math.random(1, 254), love.math.random(1, 254), love.math.random(1, 254))
		p2 = { x=love.math.random(0, w), y=0, r=love.math.random(3, 20) }
	end
	
end

function love.draw ()
    love.graphics.circle('fill', p1.x, p1.y-p1.r, p1.r)
    love.graphics.circle('fill', p2.x,p2.y, p2.r)
end