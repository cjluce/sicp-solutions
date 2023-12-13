;; *Exercise 1.42:* Let f and g be two one-argument functions.  The
;; "composition" f after g is defined to be the function x |->
;; f(g(x)).  Define a procedure `compose' that implements composition.
;; For example, if `inc' is a procedure that adds 1 to its argument,

;;      ((compose square inc) 6)
;;      49

(define (square x) (* x x))
(define (inc x) (+ x 1))
(square (inc 6))

(define (sicp/compose f g)
  ;; return a fn s.t. x -> f(g(x))
  (lambda (x) (f (g x))))
((sicp/compose square inc) 6)
