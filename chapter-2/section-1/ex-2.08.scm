;; *Exercise 2.8:* Using reasoning analogous to Alyssa's, describe how
;; the difference of two intervals may be computed.  Define a
;; corresponding subtraction procedure, called `sub-interval'.

(load "/home/lucec/classes/sicp/chapter-2/section-1/interval.scm")

;; We need to deduce what the minimum and maximum bounds would be as a
;; result of subtracting two intervals
;;   I         J
;; [a, b] - [c, d]
;; Take i in I, j in J.
;; i - j is in [a - d, b - c]
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
		 (- (upper-bound x) (lower-bound y))))
