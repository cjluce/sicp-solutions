#lang sicp

(#%require sicp-pict)

;; *Exercise 2.45:* `Right-split' and `up-split' can be expressed as
;; instances of a general splitting operation.  Define a procedure
;; `split' with the property that evaluating

;; produces procedures `right-split' and `up-split' with the same
;; behaviors as the ones already defined.

(define (split primary secondary)
  (define (rec-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (rec-split painter (- n 1))))
          (primary painter (secondary smaller smaller)))))
  rec-split)

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 2))
(paint (up-split einstein 2))
