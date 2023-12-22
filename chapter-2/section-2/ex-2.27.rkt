#lang sicp

;; *Exercise 2.27:* Modify your `reverse' procedure of *Note Exercise
;; 2-18:: to produce a `deep-reverse' procedure that takes a list as
;; argument and returns as its value the list with its elements
;; reversed and with all sublists deep-reversed as well.  For example,

(define x (list (list 1 2) (list 3 4)))

;; this works but does unnecessary checking
;; (define (deep-reverse lst)
;;   (if (null? lst) nil
;;       (append (deep-reverse (cdr lst))
;;               (list (if (pair? (car lst))
;;                         (deep-reverse (car lst))
;;                         (car lst))))))

;; note: (pair? nil) is false
(define (deep-reverse lst)
  (if (pair? lst)
      (append (deep-reverse (cdr lst))
              (list (deep-reverse (car lst))))
      lst))
x
;; ((1 2) (3 4))

(reverse x)
;; ((3 4) (1 2))

(deep-reverse x)
;; ((4 3) (2 1))

