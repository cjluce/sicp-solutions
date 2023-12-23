#lang sicp

;; *Exercise 2.31:* Abstract your answer to *Note Exercise 2-30:: to
;; produce a procedure `tree-map' with the property that
;; `square-tree' could be defined as

(define (square x)
  (* x x))

(define (tree-map proc t)
  (cond ((pair? t)
         (cons (tree-map proc (car t))
               (tree-map proc (cdr t))))
        ((null? t) nil)
        (else (proc t))))

(define (square-tree tree) (tree-map square tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))

