;; *Lame's Theorem:* If Euclid's Algorithm requires k steps to compute
;; the GCD of some pair, then the smaller number in the pair must be
;; greater than or equal to the kth Fibonacci number.(2)

;; *Exercise 1.20:* The process that a procedure generates is of
;; course dependent on the rules used by the interpreter.  As an
;; example, consider the iterative `gcd' procedure given above.
;; Suppose we were to interpret this procedure using normal-order
;; evaluation, as discussed in section *Note 1-1-5::.  (The
;; normal-order-evaluation rule for `if' is described in *Note Exercise
;; 1-5::.)  Using the substitution method (for normal order),
;; illustrate the process generated in evaluating `(gcd 206 40)' and
;; indicate the `remainder' operations that are actually performed.
;; How many `remainder' operations are actually performed in the
;; normal-order evaluation of `(gcd 206 40)'?  In the
;; applicative-order evaluation?


(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; applicative-order evaluation:
(gcd 206 40) ; 1
(gcd 40 6)   ; 2
(gcd 6 4)    ; 3
(gcd 4 2)    ; 4
(gcd 2 0)    ; no remainder call

;; normal-order evaluation: the bulk of the actual calls to remainder
;; are when computing the if statements
(gcd 206 40) 
(gcd 40
     (remainder
      206 40)) ; 1 
(gcd (remainder
      206 40)
     (remainder
      40 (remainder
	  206 40))) ; 3
(gcd (remainder
      40 (remainder
	  206 40))
     (remainder
      (remainder
       206 40)
      (remainder
       40 (remainder
	   206 40)))) ; 7
(gcd (remainder
      (remainder
       206 40)
      (remainder
       40 (remainder
	   206 40)))
     (remainder
      (remainder
       40 (remainder
	   206 40))
      (remainder
       (remainder
	206 40)
       (remainder
	40 (remainder
	    206 40))))) ; 14
(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; 18

