;; *Exercise 1.32:*
;;   a. Show that `sum' and `product' (*Note Exercise 1-31::) are
;;      both special cases of a still more general notion called
;;      `accumulate' that combines a collection of terms, using some
;;      general accumulation function:

;;           (accumulate combiner null-value term a next b)

;;      `Accumulate' takes as arguments the same term and range
;;      specifications as `sum' and `product', together with a
;;      `combiner' procedure (of two arguments) that specifies how
;;      the current term is to be combined with the accumulation of
;;      the preceding terms and a `null-value' that specifies what
;;      base value to use when the terms run out.  Write `accumulate'
;;      and show how `sum' and `product' can both be defined as
;;      simple calls to `accumulate'.

;;   b. If your `accumulate' procedure generates a recursive process,
;;      write one that generates an iterative process.  If it
;;      generates an iterative process, write one that generates a
;;      recursive process.

(define (accumulate combiner null-value term a next b)
  (if (> (term a) b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))
;; sum from 1 to 5
(accumulate + 0 (lambda (x) x) 1 (lambda (x) (+ x 1)) 5)
;; 5!
(accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) 5)

(define (accumulate combiner null-value term a next b)
  (define (iter current result)
    (if (> current b)
        result
        (iter (next current) (combiner result (term current)))))
  (iter a null-value))
