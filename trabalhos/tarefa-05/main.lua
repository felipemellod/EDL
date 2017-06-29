-- Objetivo: "Pegar" círculos menores que o seu, até que você alcance um tamanho máximo, e assim ganhe o jogo.
-- Controles: Apenas utilizar as setas para movimentar o seu círculo para "pegar", ou fugir de, outros círculos.
-- Como ganhar/perder: Se você "pegar" um círculo maior que o seu, você perde.

local gameover = "Você perdeu"
local youwon = "Parabéns, você ganhou!"
-- Nome: variável "youwon"
-- Propriedade: Endereço
-- Binding time: Compilação
-- Explicação: Por ser uma variável global, seu espaço é alocado na memória em tempo de compilação.
local buttons1 = {"Try again", "OK", enterbutton=2}
local buttons2 = {"Play again", "OK", enterbutton=2}

function love.load ()
	love.graphics.setBackgroundColor (255, 255, 255)
	w = love.graphics.getWidth()
	-- Nome: variável "w"
	-- Propriedade: Endereço
	-- Binding time: Execução
	-- Explicação: Por se tratar de uma variável local, seu espaço na memória é alocado em tempo de execução.
	h = love.graphics.getHeight()
	love.graphics.setColor(0, 0, 0)
    p1 = { x=50,  y=h-6, r=7 }
	love.graphics.setColor(love.math.random(1, 254), love.math.random(1, 254), love.math.random(1, 254))
    p2 = { x=50, y=0, r=6 }	
end

function love.keypressed (key)
	-- Nome: função "function"
	-- Propriedade: Semântica
	-- Binding Time: Design
	-- Explicação: A semântica de uma função é definida antes de qualquer coisa do programa, em tempo de design da linguagem.
    if key == 'left' then
	-- Nome: condicional "if"
	-- Propriedade: Estrutura de controle
	-- Binding time: Design
	-- Explicação: Por ser uma palavra reservada, sua "função" é dita em tempo de design da linguagem (manual).
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
	-- Nome: Operador "+"
	-- Propriedade: Semântica
	-- Binding time: Compilação
	-- Explicação: A semântica de operadores varia (entre tempo de implementação e compilação) de acordo com as linguagens.
	-- Como LUA não possui tempo de implementação, a semântica de operadores ocorre em tempo de compilação.
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
			-- Nome: Retorno função "love.math.random(3, 20)"
			-- Propriedade: Tipo de retorno 
			-- Binding time: Compilação
			-- Explicação: O tipo de retorno de uma função só pode ser "descoberto" em tempo de compilação.
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
	-- Nome: função random()
	-- Propriedade: Valor
	-- Binding time: Execução
	-- Explicação: O valor retornado por essa função será gerado e passado apenas durante a execução do programa.
	
end

function love.draw ()
    love.graphics.circle('fill', p1.x, p1.y-p1.r, p1.r)
    love.graphics.circle('fill', p2.x,p2.y, p2.r)
end
