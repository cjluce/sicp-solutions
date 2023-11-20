;; *Exercise 1.11:* A function f is defined by the rule that f(n) = n
;; if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>= 3.  Write
;; a procedure that computes f by means of a recursive process.  Write
;; a procedure that computes f by means of an iterative process.

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f-i n)
  (define (f-iter k fn-1 fn-2 fn-3)
    (if (= k n)
	(+ fn-1 (* 2 fn-2) (* 3 fn-3))
	(f-iter (+ k 1)
		(+ fn-1 (* 2 fn-2) (* 3 fn-3))
		fn-1
		fn-2)))
  (if (< n 2)
      n
      (f-iter 3 2 1 0)))

(f 13)
(f-i 13)
