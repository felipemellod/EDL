import Html exposing (text)

type alias Ambiente = (String -> Int)

type Exp = Num Int
         | Soma Exp Exp
         | Sub Exp Exp
         | Mult Exp Exp
         | Div Exp Exp
         | Var String
         | Igual Exp Exp
         | Dif Exp Exp
         
type Com = Attr String Exp
         | Seq Com Com
         | If Exp Com Com
         | While Exp Com
       
zero: Ambiente
zero = \ask -> 0

e1: Exp
e1 = Soma (Num 9) (Num 11)

avalia_exp: Exp -> Ambiente -> Int
avalia_exp e a =
  case e of
    Num i -> i
    Soma s1 s2  -> (avalia_exp s1 a) + (avalia_exp s2 a)
    Sub s1 s2   -> (avalia_exp s1 a) - (avalia_exp s2 a)
    Mult m1 m2  -> (avalia_exp m1 a) * (avalia_exp m2 a)
    Div d1 d2   -> (avalia_exp d1 a) // (avalia_exp d2 a)
    Var v       -> (a v)
    Igual e1 e2 -> if (avalia_exp e1 a) == (avalia_exp e2 a) then 1 else 0
    Dif e1 e2   -> if (avalia_exp e1 a) /= (avalia_exp e2 a) then 1 else 0
    
avalia_com: Com -> Ambiente -> Ambiente
avalia_com c a =
  case c of
    Seq s1 s2 -> (avalia_com s2 (avalia_com s1 a))
    
    Attr s e ->
      let 
        v = (avalia_exp e a)
      in
        \ask -> if ask == s then v else (a ask)
        
    If cond com1 com2 ->
      if (avalia_exp cond a) /= 0 then
        (avalia_com com1 a)
      else
        (avalia_com com2 a)
        
    While cond com ->
      if (avalia_exp cond a) == 0 then
        a
      else
        (avalia_com (While cond com) (avalia_com com a))
        
lang : Com -> Int
lang p = ((avalia_com p zero) "ret")

p1 : Com -- ((((10+10)-5)*2)/3) = 10
p1 = (Seq
        (Attr "x" (Num 10))
        (Seq
          (Attr "ret" (Soma (Var "x") (Num 10)))
          (Seq
            (Attr "ret" (Sub (Var "ret") (Num 5)))
            (Seq
              (Attr "ret" (Mult (Var "ret") (Num 2)))
              (Attr "ret" (Div (Var "ret") (Num 3)))
            )
          )
        )
      )
      
p2 : Com -- 5 == 6 ? 1:0
p2 = If (Igual (Num 5) (Num 6)) (Attr "ret" (Num 1)) (Attr "ret" (Num 0))

p3 : Com -- 5 == 5 ? 1:0
p3 = If (Igual (Num 5) (Num 5)) (Attr "ret" (Num 1)) (Attr "ret" (Num 0))

p4 : Com -- 2^6
p4 = (Seq
        (Attr "i" (Num 0))
        (Seq
          (Attr "ret" (Num 1))
          (While (Dif (Var "i") (Num 6))
            (Seq
              (Attr "i" (Soma (Var "i") (Num 1)))
              (Attr "ret" (Mult (Var "ret") (Num 2)))
            )
          )
        )
      )
      
main = text (toString (lang p4))
