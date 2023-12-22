#lang sicp

;; *Exercise 2.28:* Write a procedure `fringe' that takes as argument
;; a tree (represented as a list) and returns a list whose elements
;; are all the leaves of the tree arranged in left-to-right order.
;; For example,

(define x (list (list 1 2) (list 3 4)))

(define (fringe lst)
  (cond ((pair? lst)
         (append (fringe (car lst))
                 (fringe (cdr lst))))
        ((null? lst) nil)
        (else (list lst))))

;; I could see this function being more generally useful working with
;; trees.
(define (listify x)
  ;; If x is a list or nil, then return it. Else, wrap it in a list.
  (if (or (pair? x) (null? x))
      x
      (list x)))
(define (fringe-with-listify lst)
  (if (pair? lst)
      (append (fringe-with-listify (car lst))
              (fringe-with-listify (cdr lst)))
      (listify lst)))

(fringe-with-listify (list x x))

(fringe x)
;; (1 2 3 4)

(fringe (list x x))
;; (1 2 3 4 1 2 3 4)

