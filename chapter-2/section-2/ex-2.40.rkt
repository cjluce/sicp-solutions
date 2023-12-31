#lang sicp

;; *Exercise 2.40:* Define a procedure `unique-pairs' that, given an
;; integer n, generates the sequence of pairs (i,j) with 1 <= j< i <=
;; n.  Use `unique-pairs' to simplify the definition of
;; `prime-sum-pairs' given above.

(#%require "accumulate.rkt")
(#%require "prime.rkt")
(#%require "filter.rkt")
(#%require "flatmap.rkt")


(define (enumerate-interval a b)
  ;; Create a list containing integers in [a, b]
  (if (> a b)
      nil
      (cons a (enumerate-interval (+ a 1) b))))

;; Using recursion
;; (define (unique-pairs n)
;;   (if (<= n 1)
;;      nil
;;       (append (map (lambda (x) (cons n x)) (enumerate-interval 1 (- n 1)))
;;               (unique-pairs (- n 1)))))


(define (unique-pairs n)
  (accumulate 
   append
   nil
   (map (lambda (i)
          (map (lambda (j) 
                 (list i j))
               (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

(prime-sum-pairs 10)
