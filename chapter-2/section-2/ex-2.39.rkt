#lang sicp

;; *Exercise 2.39:* Complete the following definitions of `reverse'
;; (*Note Exercise 2-18::) in terms of `fold-right' and `fold-left'
;; from *Note Exercise 2-38:::


(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (reverse-fr sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))
(reverse-fr '(1 2 3))

(define (reverse-fl sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))
(reverse-fl '(1 2 3))
