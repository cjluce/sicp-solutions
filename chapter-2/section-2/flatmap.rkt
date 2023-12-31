#lang sicp

(#%require "accumulate.rkt")

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(#%provide (all-defined))
