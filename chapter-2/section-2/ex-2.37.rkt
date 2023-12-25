#lang sicp

(#%require "accumulate.rkt")

;; Exercise 2.37
;; Suppose we represent vectors v = (v_i) as sequences of numbers, and
;; matrices m = (m_(ij)) as sequences of vectors (the rows of the matrix).
;; For example, the matrix

;;      +-         -+
;;      |  1 2 3 4  |
;;      |  4 5 6 6  |
;;      |  6 7 8 9  |
;;      +-         -+

;; is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))'.  With
;; this representation, we can use sequence operations to concisely
;; express the basic matrix and vector operations.  These operations
;; (which are described in any book on matrix algebra) are the following:

;;                                             
;;      (dot-product v w)      returns the sum(v_i w_i) over i

;;      (matrix-*-vector m v)  returns the vector t,
;;                                         
;;                             where t_i = sum(m_(ij) v_j) over j

;;      (matrix-*-matrix m n)  returns the matrix p,
;;                                            
;;                             where p_(ij) = sum(m_(ik) n_(kj)) over k

;;      (transpose m)          returns the matrix n,
;;                             where n_(ij) = m_(ji)

;;    We can define the dot product as(4)

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;;    Fill in the missing expressions in the following procedures for
;; computing the other matrix operations.  (The procedure `accumulate-n'
;; is defined in *Note Exercise 2-36::.)

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))

(matrix-*-vector '((1 2) (3 4)) '(1 2))
;; (5 11)

(define (transpose mat)
  (accumulate-n cons nil mat))

(transpose '((1 2 3) (4 5 6)))
;; ((1 4) (2 5) (3 6))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (matrix-*-vector cols row)) m)))
(matrix-*-matrix '((1 2) (3 4)) '((1 2) (3 4)))
;; ((7 10) (15 22))
