;; *Exercise 1.3:* Define a procedure that takes three numbers as
;; arguments and returns the sum of the squares of the two larger
;; numbers.

(define (sum-two-largest x y z)
  (if (< x y)
      (+ y (if (< x z) z x))
      (+ x (if (< y z) z y))))

(= (sum-two-largest 1 2 3)
   (sum-two-largest 1 3 2)
   (sum-two-largest 2 1 3)
   (sum-two-largest 3 1 2)
   (sum-two-largest 2 3 1)
   (sum-two-largest 3 2 1))
