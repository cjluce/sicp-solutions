;; *Exercise 1.33:* You can obtain an even more general version of
;; `accumulate' (*Note Exercise 1-32::) by introducing the notion of
;; a "filter" on the terms to be combined.  That is, combine only
;; those terms derived from values in the range that satisfy a
;; specified condition.  The resulting `filtered-accumulate'
;; abstraction takes the same arguments as accumulate, together with
;; an additional predicate of one argument that specifies the filter.
;; Write `filtered-accumulate' as a procedure.  Show how to express
;; the following using `filtered-accumulate':

;;   a. the sum of the squares of the prime numbers in the interval a
;;      to b (assuming that you have a `prime?' predicate already
;;      written)

;;   b. the product of all the positive integers less than n that are
;;      relatively prime to n (i.e., all positive integers i < n such
;;      that GCD(i,n) = 1).

(define (filtered-accumulate combiner null-value term a next b filter?)
  (define (iter current result)
    (if (> current b)
        result
        (iter (next current)
              (if (filter? (term current))
                  (combiner result (term current))
                  result))))
  (iter a null-value))

(define (sum-primes a b)
  (filtered-accumulate + 0 (lambda (x) x) a (lambda (x) (+ x 1)) b prime?))

(define (prod-rel-prime n)
  (define (rel-prime? x) (= (gcd x n) 1))
  (filtered-accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) n rel-prime?))

(prod-rel-prime 5)
