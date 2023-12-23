#lang sicp

(#%require "accumulate.rkt")

;; *Exercise 2.33:* Fill in the missing expressions to complete the
;; following definitions of some basic list-manipulation operations
;; as accumulations:

(define (sicp/map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
(sicp/map (lambda (x) (+ x 1)) '(1 2 3))

(define (sicp/append seq1 seq2)
  (accumulate cons seq2 seq1))
(sicp/append '(1 2 3) '(4 5 6))

(define (sicp/length sequence)
  (accumulate (lambda (first rest) (+ 1 rest)) 0 sequence))
(sicp/length '(1 2 3))

