#lang sicp

(#%require "accumulate.rkt")

;; *Exercise 2.35:* Redefine `count-leaves' from section *Note
;; 2-2-2:: as an accumulation:

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (sub-t)
                     (if (pair? sub-t)
                         (count-leaves sub-t)
                         1)) t)))

(count-leaves (list 1 2 (list 3 4 (list 5 6))))
