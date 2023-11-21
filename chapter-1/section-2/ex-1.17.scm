;; *Exercise 1.17:* The exponentiation algorithms in this section are
;; based on performing exponentiation by means of repeated
;; multiplication.  In a similar way, one can perform integer
;; multiplication by means of repeated addition.  The following
;; multiplication procedure (in which it is assumed that our language
;; can only add, not multiply) is analogous to the `expt' procedure:

;; This algorithm takes a number of steps that is linear in `b'.  Now
;; suppose we include, together with addition, operations `double',
;; which doubles an integer, and `halve', which divides an (even)
;; integer by 2.  Using these, design a multiplication procedure
;; analogous to `fast-expt' that uses a logarithmic number of steps.

(define (double x) (+ x x))

;; just a fun way i thought of to compute a half... needs some
;; optimization
(define (halve x)
  (define (iter quotient dividend last-quotient)
    (cond ((= dividend x) quotient)
	  ((> dividend x)
	   (iter (+ 1 last-quotient)
		 (double (+ 1 last-quotient))
		 last-quotient))
	  (else (iter (double quotient)
		      (double dividend)
		      quotient))))
  (iter 1 2 1))

(define (mul a b)
  (cond ((= b 0) 0)
	((even? b) (double (mul a (halve b))))
	(else (+ a (mul a (- b 1))))))

(mul 4 9)
