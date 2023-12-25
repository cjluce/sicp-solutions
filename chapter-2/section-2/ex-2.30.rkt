#lang sicp

;; *Exercise 2.30:* Define a procedure `square-tree' analogous to the
;; `square-list' procedure of *Note Exercise 2-21::.  That is,
;; `square-list' should behave as follows:

;; Define `square-tree' both directly (i.e., without using any
;; higher-order procedures) and also by using `map' and recursion.

(define (square x)
  (* x x))

(define (square-tree t)
  (cond ((pair? t)
         (cons (square-tree (car t))
               (square-tree (cdr t))))
        ((null? t) nil)
        (else (square t))))

(define (square-tree-map t)
  (if (pair? t)
      (map square-tree-map t)
      (square t)))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-tree-map
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))
