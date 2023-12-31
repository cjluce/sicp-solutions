#lang sicp

;; *Exercise 2.47:* Here are two possible constructors for frames:

;; For each constructor supply the appropriate selectors to produce an
;; implementation for frames.

(define (make-frame-1 origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame-1 f)
  (car f))
(define (edge1-frame-1 f)
  (cadr f))
(define (edge2-frame-1 f)
  (caddr f))

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame-2 f)
  (car f))
(define (edge1-frame-2 f)
  (cadr f))
(define (edge2-frame-2 f)
  (cddr f))
