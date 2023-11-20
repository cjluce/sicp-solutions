;; *Exercise 1.7:* The `good-enough?' test used in computing square
;; roots will not be very effective for finding the square roots of
;; very small numbers.  Also, in real computers, arithmetic operations
;; are almost always performed with limited precision.  This makes our
;; test inadequate for very large numbers.  Explain these statements,
;; with examples showing how the test fails for small and large
;; numbers.  An alternative strategy for implementing `good-enough?'
;; is to watch how `guess' changes from one iteration to the next and
;; to stop when the change is a very small fraction of the guess.
;; Design a square-root procedure that uses this kind of end test.
;; Does this work better for small and large numbers?

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sicp/sqrt x)
  (sqrt-iter 1.0 x))

;; for large numbers, this implementation of sqrt enters an infinite
;; recursion. this is because the relative distance between two large
;; numbers (for n greater than some N) will never be less than 0.001
;; -- as the floating point arithmetic simply can't handle the
;; precision. for small numbers, the answer is trivial: this test is
;; unable to calculate roots when the true root is << 0.001.

;; changing the implementation of good-enough? does indeed solve both
;; of these issues (though we are still bound by floating-point
;; precision)

(define (good-enough? guess x)
  (< (/ (abs (- guess (improve guess x)))
	guess) 0.001))

(sicp/sqrt 0.000000001)
