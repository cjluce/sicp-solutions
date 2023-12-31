#lang sicp

;; *Exercise 2.41:* Write a procedure to find all ordered triples of
;; distinct positive integers i, j, and k less than or equal to a
;; given integer n that sum to a given integer s.

(#%require "accumulate.rkt")
(#%require "flatmap.rkt")
(#%require "filter.rkt")

(define (enumerate-interval a b)
  ;; Create a list containing integers in [a, b]
  (if (> a b)
      nil
      (cons a (enumerate-interval (+ a 1) b))))

(define (enumerate-pairs n)
  ;; Get all pairs (j, i) where 1 <= i < j <= n
  (flatmap (lambda (x)
             (map (lambda (y)
                    (cons x y))
                  (enumerate-interval 1 (- x 1))))
           (enumerate-interval 1 n)))

(define (enumerate-triples n)
  ;; Get all triples (k, j, i) where 1 <= i < j < k <= n
  (flatmap (lambda (k)
             (flatmap (lambda (j)
                    (map (lambda (i)
                           (list k j i))
                         (enumerate-interval 1 (- j 1))))
                  (enumerate-interval 1 (- k 1))))
           (enumerate-interval 1 n)))

(enumerate-pairs 3)
(enumerate-triples 4)

(define (triple-sum n s)
  (filter (lambda (triple)
            (= (accumulate + 0 triple) s))
          (enumerate-triples n)))

(triple-sum 5 10)
