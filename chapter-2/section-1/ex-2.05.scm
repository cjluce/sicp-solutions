;; *Exercise 2.5:* Show that we can represent pairs of nonnegative
;; integers using only numbers and arithmetic operations if we
;; represent the pair a and b as the integer that is the product 2^a
;; 3^b.  Give the corresponding definitions of the procedures `cons',
;; `car', and `cdr'.

(define (make-pair x y)
  (* (expt 2 x) (expt 3 y)))

(define (x-pair p)
  (if (= 0 (modulo p 2))
      (+ 1 (x-pair (/ p 2)))
      0))

(define (y-pair p)
  (if (= 0 (modulo p 3))
      (+ 1 (y-pair (/ p 3)))
      0))

(x-pair (make-pair 12 8))
(y-pair (make-pair 6 11))
