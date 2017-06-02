-- Objetivo: "Pegar" círculos menores que o seu, até que você alcance um tamanho máximo, e assim ganhe o jogo.
-- Controles: Apenas utilizar as setas para movimentar o seu círculo para "pegar", ou fugir de, outros círculos.
-- Como ganhar/perder: Se você "pegar" um círculo maior que o seu, você perde.

local buttons1 = {"Try again", "OK", enterbutton=2}
local buttons2 = {"Play again", "OK", enterbutton=2}
pontuacao = {}
-- trabalho 06
-- pontuacao = {} é um array que guardará a pontuação do jogador.


function love.load ()
	love.graphics.setBackgroundColor (255, 255, 255)
	w = love.graphics.getWidth()
	-- Nome: variável "w"
	-- Propriedade: Alocação de memória
	-- Binding time: Execução
	-- Apesar do tamanho da variável ser conhecido em tempo de compilação,
	-- a alocação de memória dessa variável local é feita em tempo de execução.
	pont=0
	h = love.graphics.getHeight()
	love.graphics.setColor(0, 0, 0)
	pos = {x=5, y=5}
	-- trabalho 06
	-- pos = {x=5, y=5} é uma tupla contruída para guardar a posição da informação da pontuação do jogador.
    p1 = { x=50,  y=h-6, r=7 }
	-- trabalho 06
	-- p1 = { x=50, y=h-6, r=7 } é um exemplo de registro com três valores inteiros
	
	--trabalho 07
	-- Escopo: Apesar de o objeto "p1" estar sendo criado dentro da função "love.load", ele não foi explicitado como local,
	-- e portanto pode ser visto em qualquer parte do código, logo ele é uma variável global.
	-- Tempo de vida: O objeto "p1" dura enquanto o jogo estiver em execução.
	-- Alocação: Sua alocação ocorre dentro da função "love.load"
	-- Desalocação: Ele é desalocado ao fim do jogo.
	love.graphics.setColor(love.math.random(10, 240), love.math.random(10, 240), love.math.random(10, 240))
    p2 = { x=50, y=0, r=6 }	
	-- trabalho 07
	-- Escopo: Assim como o objeto "p1", "p2" também é uma variável global.
	-- Tempo de vida: Esse objeto dura enquanto não ultrapassa o limite da tela ou enquanto não colide com o objeto "p1".
	-- Alocação: Sua alocação também ocorre dentro da função "love.load".
	-- Desalocação: É desalocado quando ultrapassa o limite da tela ou quando colide com p1.
end

function love.keypressed (key)
	-- Nome: função "function"
	-- Propriedade: Função
	-- Binding Time: Design
	-- Explicação: O comportamento de uma função é definido antes de qualquer coisa do programa, em tempo de design da linguagem.
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
	-- Propriedade: operador matemático
	-- Binding time: Compilação
	-- Explicação: A semântica de operadores varia (entre tempo de implementação e compilação) de acordo com as linguagens.
	-- Como LUA não possui tempo de implementação, a semântica de operadores ocorre em tempo de compilação.
	if love.keyboard.isDown("left") then
		p1.x = p1.x - 0.3
	elseif love.keyboard.isDown("right") then
		p1.x = p1.x + 0.3
	end

	local gameover = string.format("Você perdeu! Sua pontuação foi: %d pontos", pont)
	local youwon = string.format("Parabéns, você ganhou! Sua pontuação foi: %d pontos", pont)
	-- Nome: variável "youwon"
	-- Propriedade: Atribuição
	-- Binding time: Execução
	-- Explicação: A atribuição de um valor à uma variável
	-- só pode ser feita em tempo de execução.
	
    if collides(p1, p2) then
		if p1.r <= p2.r then
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
			p1.r = p1.r + (p2.r/2)
			p2.r = 0
			pont = pont + 1
		end
		if (p2.r == 0) then
			love.graphics.setColor(love.math.random(10, 240), love.math.random(10, 240), love.math.random(10, 240))
			p2 = { x=love.math.random(0, w), y=0, r=love.math.random(3, 50) }
			-- Nome: Retorno função "love.math.random(3, 20)"
			-- Propriedade: Tipo de retorno 
			-- Binding time: Compilação
			-- Explicação: O tipo de retorno de uma função só pode ser "descoberto" em tempo de compilação.
			
			-- trabalho 07
			-- Igual ao que foi descrito para o objeto "p2". A única mudança foi a alocação.
			-- Alocação: É alocado dentro da função "love.update". Esse é o caso em que o objeto já foi desalocado e está
			-- sendo alocado novamente.
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
	
	if (p2.y > h) then
		love.graphics.setColor(love.math.random(10, 240), love.math.random(10, 240), love.math.random(10, 240))
		p2 = { x=love.math.random(0, w), y=0, r=love.math.random(3, 50) }
		-- trabalho 07
		-- Igual ao que foi descrito para o objeto "p2". A única mudança foi a alocação.
		-- Alocação: É alocado dentro da função "love.update". Esse é o caso em que o objeto já foi desalocado e está
		-- sendo alocado novamente.
	end
	
end

function love.draw ()
    love.graphics.circle('fill', p1.x, p1.y-p1.r, p1.r)
    love.graphics.circle('fill', p2.x,p2.y, p2.r)
	love.graphics.printf(string.format("Pontuação: %d", pont), pos.x, pos.y, 150, "left")
	-- trabalho 06
	-- O parâmetro "AlignMode" da função love.graphics.printf se refere ao alinhamento do texto. Ele tem três possíveis valores: "center", "left" e "right"
end