(defglobal ?*limite* = 3)
;no he utilizado la def global porque me da problemas

(deffacts pedido 
(robot naranjas 0 manzanas 0 uvas 0 caquis 0)
(pedido naranjas 0 manzanas 0 uvas 0 caquis 0)
(res naranjas 2  manzanas 3  uvas 1 caquis 0)
(palet_naranjas 4)
(palet_manzanas 4)
(palet_uvas 4)
(palet_caquis 4)
(limite 3)
)

(defrule meta
	(robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (pedido naranjas ?pen manzanas ?pem uvas ?peu caquis ?pec)
    (res naranjas ?nf  manzanas ?mf  uvas ?uf caquis ?cf)
    (test (<> (+ (+ ?n ?m) (+ ?u ?c)) 0)) ;porque al principio todo está a cero
	(test (= (+ ?n ?pen) ?nf))
    (test (= (+ ?m ?pem) ?mf))
    (test (= (+ ?u ?peu) ?uf))
    (test (= (+ ?c ?pec) ?cf))
	=>
	(printout t "Pedido completado" crlf)
	(assert (robot naranjas ?n manzanas ?m uvas ?u caquis ?c))
	(halt)
)

(defrule lleno
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (limite ?l)
    (test (>= (+ (+ ?n ?m) (+ ?u ?c)) ?l))
    =>
    (assert (pedido naranjas ?n manzanas ?m uvas ?u caquis ?c))
)

(defrule recoger_naranjas
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (palet_naranjas ?pn)
    (limite ?l)
    (test (<= ?pn ?l))
    (test (>= ?pn ?n))
    =>
    (assert (robot naranjas ?pn manzanas ?m uvas ?u caquis ?c))
)

(defrule recoger_manzanas
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (palet_manzanas ?pm)
    (limite ?l)
    (test (<= ?pm ?l))
    (test (>= ?pm ?m))
    =>
    (assert (robot naranjas ?n manzanas ?pm uvas ?u caquis ?c))
)

(defrule recoger_uvas
    (robot naranjas ?n manzanas ?m uvas ?u caquis ?c)
    (palet_uvas ?pu)
    (limite ?l)
    (test (<= ?pu ?l))
    (test (>= ?pu ?u))
    =>
    (assert (robot naranjas ?n manzanas ?m uvas ?pu caquis ?c))
)

(defrule recoger_caquis
    (robot naranjas ?n manzanas ?m uvas ?v caquis ?c)
    (palet_caquis ?pu)
    (limite ?l)
    (test (<= ?pu ?l))
    (test (>= ?pu ?n))
    =>
    (assert (robot naranjas ?n manzanas ?m uvas ?v caquis ?pu))
)



