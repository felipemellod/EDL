-- Objetivo: "Pegar" círculos menores que o seu, até que você alcance um tamanho máximo, e assim ganhe o jogo.
-- Controles: Apenas utilizar as setas para movimentar o seu círculo para "pegar", ou fugir de, outros círculos.
-- Como ganhar/perder: Se você "pegar" um círculo maior que o seu, você perde.

local buttons1 = {"Try again", "OK", enterbutton=2}
local buttons2 = {"Play again", "OK", enterbutton=2}
pontuacao = {}

--[[
	trabalho 07
	Array "objetos":
	
	Escopo: A array "objetos" é uma variável global, ou seja, pode ser vista em qualquer parte do programa.
	
	Tempo de vida: O tempo de vida da array é a duração da execução do jogo (tempo de vida estático).
	
	Alocação: A array "objetos" é alocada durante a função love.load, e aumentada dinâmicamente ao decorrer do jogo.
	
	Desalocação: É desalocada ao fim do programa, pois é uma variável global.
]]--


function love.load ()
	love.graphics.setBackgroundColor (255, 255, 255)
	w = love.graphics.getWidth()
	pont=0
	objetos={}
	h = love.graphics.getHeight()
	love.graphics.setColor(0, 0, 0)
	pos = {x=5, y=5}
    p1 = { x=50,  y=h-6, r=7 }
	love.graphics.setColor(love.math.random(10, 240), love.math.random(10, 240), love.math.random(10, 240))
    obj = { x=50, y=0, r=6 }
	table.insert(objetos, obj)
	
	--[[
		trabalho 07
		Objeto da array "objetos":
		
		Escopo: Como a array "objetos" é global, seu elemento também será global.
		
		Tempo de vida: Seu tempo de vida vai desde quando ele é criado até sua remoção (p1 "pega" o objeto ou o objeto sai da tela)
		
		Alocação: Ele será criado, e alocado na array, quando outro elemento tiver sido removido/destruído.
		
		Desalocação: Será desalocado quando tiver sido "pego" pelo p1, ou quando tiver saído da tela
	
	]]--

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
    obj.y = obj.y + 0.3

	if love.keyboard.isDown("left") then
		p1.x = p1.x - 0.3
	elseif love.keyboard.isDown("right") then
		p1.x = p1.x + 0.3
	end

	local gameover = string.format("Você perdeu! Sua pontuação foi: %d pontos", pont)
	local youwon = string.format("Parabéns, você ganhou! Sua pontuação foi: %d pontos", pont)
	
    if collides(p1, obj) then
		if p1.r <= obj.r then
			p1.r=0
			msg1 = love.window.showMessageBox('GAME OVER', gameover, buttons1, info)
			if msg1 == 1 then
				love.event.quit('restart')
				pontuacao[#pontuacao+1] = pont
			elseif msg1 == 2 then
				love.event.quit(0)
				pontuacao[#pontuacao+1] = pont
			end
		else
			p1.r = p1.r + (obj.r/2)
			obj.r = 0
			pont = pont + 1
			for i=#objetos, 1, -1 do
				if(objetos[i].r == 0) then
					table.remove(objetos, i)
				end
			end
		end
		if (obj.r == 0) then
			love.graphics.setColor(love.math.random(10, 240), love.math.random(10, 240), love.math.random(10, 240))
			obj = { x=love.math.random(0, w), y=0, r=love.math.random(3, 50) }
			table.insert(objetos, obj)

		end
		if (p1.r >= h/2) then
			msg2 = love.window.showMessageBox('YOU WON', youwon, buttons2, info)
			if msg2 == 1 then
				love.event.quit('restart')
				pontuacao[#pontuacao+1] = pont
			elseif msg2 == 2 then
				love.event.quit(0)
			end
		end
    end
	
	if (obj.y >= h+(obj.r)) then
		obj.r = 0
		for i=#objetos, 1, -1 do
			if(objetos[i].r == 0) then
				table.remove(objetos, i)
			end
		end
		love.graphics.setColor(love.math.random(10, 240), love.math.random(10, 240), love.math.random(10, 240))
		obj = { x=love.math.random(0, w), y=0, r=love.math.random(3, 50) }
		table.insert(objetos, obj)
	end
	
end

function love.draw ()
    love.graphics.circle('fill', p1.x, p1.y-p1.r, p1.r)
	for index, o in pairs (objetos) do
		love.graphics.circle('fill', o.x, o.y, o.r)
	end
	love.graphics.printf(string.format("Pontuação: %d", pont), pos.x, pos.y, 150, "left")
end