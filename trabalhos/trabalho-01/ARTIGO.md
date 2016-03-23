#Introdução

A linguagem de programação **Fortran** surgiu na década de **1950**, para ser mais específico, o primeiro compilador FORTRAN foi desenvolvido em **1954-57**, tendo sido terminado em **1957**. O nome Fortran é um acrônimo da expressão "IBM Mathematical **FOR**mula **TRAN**slation System", que inicialmente era chamado "FORTRAN", mas a capitalização foi ignorada em versões mais recentes.


#Origens e Influências

O primeiro compilador de Fortran foi desenvolvido por uma equipe da **IBM** chefiada por John W. Backus. Se pararmos para analisar, a linguagem Fortran, por ser mais antiga, mais influenciou do que foi influenciada.

Fortran foi influenciado apenas pela **Speedcoding**. Dentre as linguagens influenciadas, por Fortran I e suas "evoluções", estão: ALGOL 58 (e suas versões posteriores), BASIC, C, PL/I, entre outras, que foram influenciadas por linguagens influenciadas por Fortran (influenciadas indiretamente por Fortran).

Se formos tentar botar essa "árvore" de influências em uma linha do tempo ela ficaria parecida com essa:

1953: Speedcoding

1957: Fortran I

1958: Fortran II e ALGOL 58

1960: ALGOL 60 (influenciado pela ALGOL 58)

1962: Fortran IV

1964: BASIC e PL/I

1968: ALGOL 68 (influenciada por ALGOL 60)

1971: C (influenciada por ALGOL 68)

1978: Fortran 77

1990: Fortran 90

1995: Fortran 95

2003: Fortran 03

2008: Fortran 08


#Classificação

Fortran é uma linguagem procedural e orientada a objetos, além de ser uma linguagem compilada.

Quanto a sua tipagem, ela é forte e estática.

Por ser uma linguagem com poucas funções da linguagem, e que por isso não precisa ficar trocando o contexto de execução toda hora (chamar as funções), e permitir a criação de programas que primam pela velocidade de execução, a linguagem Fortran é muito usada em aplicações científicas computacionalmente intensivas.


#Avaliação Comparativa

**Writability:** Por não possuir registros para armazenar tipos de dados diferentes, a redigibilidade de Fortran fica prejudicada, pois essa falta de registro faz com que exista a necessidade de criar diversos vetores, para armazenar diversos tipos de elementos, e a manipulação desses vetores acaba tornando-se uma tarefa complexa. Se usarmos essa, e outras características, como o uso dos operadores ++, --, +=, -=, para compararmos Fortran com C, vemos que a linguagem C é mais redigível do que Fortran.

**Readability:** Se continuarmos a comparar Fortran com C, vemos que Fortran é mais legível do que a linguagem C, por alguns fatos. Apesar de versões mais antigas de Fortran também usarem, o uso de goto em C permite a criação de programas difíceis de entender (o uso de goto em Fortran foi removido em versões mais recentes, e ainda foram introduzidos recursos mais modernos a partir de Fortran 77). Além disso, C permite que símbolos possam ter mais de uma atribuição, como o operador (\*)

**Expressiveness:** Quando vamos comparar a expressividade, vemos que ambas as linguagens, C e Fortran, não são muito expressivas. Se pegarmos um trecho de um código em Java, por exemplo, e passarmos para Fortran, vemos que o código precisa ser mudado radicalmente, ele fica maior, e mais difícil de se ler. Se fizermos o contrário, passarmos um trecho de um código de Fortran para Java, a estrutura principal do programa não é mudada, e o programa fica mais fácil de ser entendido. O mesmo acontece com C, quando comparamos com Java.

#Exemplo de código

Código para resolver uma equação do 2º grau em Fortran 77:

C 1 2 3 4 5 6

C2345678901234567890123456789012345678901234567890123456789012345
      
PROGRAM BASKHARA

C
REAL :: A,B,C, DELTA, X1,X2, RE, IM

C
PRINT *, "Este programa resolve uma equação de 2o.grau"
      
PRINT *, "no formato: a*x**2 + b*x + c = 0"

C
      
PRINT  10, "Digite a, b, c: "

10   FORMAT( A, 1X, $)

20   READ(*, *, ERR=20)A, B, C

C
DELTA= B**2-4.0*A*C

C
IF( DELTA.GT.0 )THEN      ! (DUAS RAÍZES REAIS)
          
X1= ( -B-SQRT(DELTA) ) / ( 2.0*A )
          
X2= ( -B+SQRT(DELTA) ) / ( 2.0*A )
          
PRINT *, "RAIZES:  X1= ", X1
          
PRINT *, "X2= ", X2
      
ELSE
          
IF( DELTA.EQ.0 ) THEN ! (DUAS RAÍZES REAIS IGUAIS)
          
X1= -B / ( 2.0*A )
          
X2= X1
          
PRINT *, "RAIZES: X1=X2= ", X1
      
ELSE                      ! (DUAS RAÍZES COMPLEXAS)
          
RE= -B / ( 2.0*A )
          
IM= SQRT( -DELTA ) / ( 2.0*A )
          
PRINT *, "RAIZES COMPLEXAS: X1= ", RE,"- ", IM, "i"
          
PRINT *, "X2= ", RE, "+ ",IM, "i"
          
END IF
      
END IF

C
END PROGRAM BASKHARA


#Bibliografia

Wikipedia: [https://pt.wikipedia.org/wiki/Fortran#Pontos_fortes.2Ffracos_da_sintaxe](https://pt.wikipedia.org/wiki/Fortran#Pontos_fortes.2Ffracos_da_sintaxe "Fortran")

Wikipedia: [https://pt.wikipedia.org/wiki/Programa%C3%A7%C3%A3o_procedural](https://pt.wikipedia.org/wiki/Programa%C3%A7%C3%A3o_procedural)

*assei direto: [https://www.passeidireto.com/arquivo/1625736/exercicioscap1](https://www.passeidireto.com/arquivo/1625736/exercicioscap1)
