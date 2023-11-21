;; *Exercise 1.18:* Using the results of *Note Exercise 1-16:: and
;; *Note Exercise 1-17::, devise a procedure that generates an
;; iterative process for multiplying two integers in terms of adding,
;; doubling, and halving and uses a logarithmic number of steps.(4)

(load "ex-1.17.scm")

;; note, this time `a + xy' remains constant
(define (mul-2 x y)
  (define (iter x y a)
    (cond ((<= y 0) a)
	  ((even? y) (iter (double x) (halve y) a))
	  (else (iter x (- y 1) (+ a x)))))
  (iter x y 0))
(mul-2 4 9)
