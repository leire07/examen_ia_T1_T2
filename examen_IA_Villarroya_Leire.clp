(defglobal ?*limite* = 3)

(deffacts pedido 
(robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
(res naranjas 2  manzanas 3  uvas 1 caquis 0)
(palet_naranjas ?pn)
(palet_manzanas ?pm)
(palet_uvas ?pu)
(palet_caquis ?pc)
(pedido naranjas 0 manzanas 0 uvas 0 caquis 0)
)

(defrule meta
	(robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (pedido naranjas ?pen manzanas ?pem uvas ?peu caquis ?pec)
    (res naranjas ?nf  manzanas ?mf  uvas ?uf caquis ?cf)
	(max ?*limite* ?l)
	(test (= (+ ?n ?pen) ?nf))
    (test (= (+ ?m ?pem) ?mf))
    (test (= (+ ?u ?peu) ?uf))
    (test (= (+ ?c ?pec) ?cf))
	=>
	(printout t "Pedido completado" crlf)
	(assert(robot naranjas ?n manzanas ?m uvas ?u caquis ?c))
	(halt)
)

(defrule lleno
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (test (>= (+ (+ ?n ?m) (+ ?u ?c)) ?*limite*)
    =>
    (assert (pedido naranjas ?n manzanas ?m uvas ?u caquis ?c))
)

(defrule recoger_naranjas
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (palet_naranjas ?pn)
    (test (<= ?pn ?*limite*))
    (test (>= ?pn ?n))
    =>
    (assert (robot naranjas ?pn manzanas ?m uvas ?u caquis ?c))
)

(defrule recoger_manzanas
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (palet_manzanas ?pm)
    (test (<= ?pm ?*limite*))
    (test (>= ?pm ?m))
    =>
    (assert (robot naranjas ?n manzanas ?pm uvas ?u caquis ?c))
)

(defrule recoger_uvas
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (palet_uvas ?pu)
    (test (<= ?pu ?*limite*))
    (test (>= ?pu ?u))
    =>
    (assert (robot naranjas ?n manzanas ?m uvas ?pu caquis ?c))
)

(defrule recoger_caquis
    (robot naranjas ?n manzanas ?m uvas ?v caquis ?c)
    (palet_caquis ?pu)
    (test (<= ?pu ?*limite*))
    (test (>= ?pu ?n))
    =>
    (assert (robot naranjas ?pn manzanas ?m uvas ?v caquis ?pu))
)



