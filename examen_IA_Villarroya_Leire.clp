(defglobal ?*limite* = 3)

(deffacts pedido 
(robot naranjas ?n manzanas ?m uvas ?v caquis ?c)
(res naranjas 2  manzanas 3  uvas 1 caquis 0)
(palet_naranjas ?pn)
(palet_manzanas ?pm)
(palet_uvas ?pu)
(palet_caquis ?pc)
(pedido naranjas 0 manzanas 0 uvas 0 caquis 0)
)

(defrule meta
	(robot naranjas ?n manzanas ?m uvas ?v caquis ?c)
    (pedido naranjas ?pen manzanas ?pem uvas ?peu caquis ?pec)
    (res naranjas ?nf  manzanas ?mf  uvas ?uf caquis ?cf)
	(max ?*limite* ?l)
	(test (= (+ ?n ?pen) ?nf))
    (test (= (+ ?m ?pem) ?mf))
    (test (= (+ ?u ?peu) ?uf))
    (test (= (+ ?c ?pec) ?cf))
	=>
	(printout t "Pedido completado" crlf)
	(assert(robot naranjas ?n manzanas ?m uvas ?v caquis ?c))
	(halt)
)

(defrule lleno
    (robot naranjas ?n manzanas ?m uvas ?v caquis ?c)
    (test (>= (+ (+ ?n ?m) (+ ?v ?c)) ?*limite*)
    =>
    (assert (pedido naranjas ?n manzanas ?m uvas ?v caquis ?c))
)




