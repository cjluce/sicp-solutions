;; *Exercise 2.12:* Define a constructor `make-center-percent' that
;; takes a center and a percentage tolerance and produces the desired
;; interval.  You must also define a selector `percent' that produces
;; the percentage tolerance for a given interval.  The `center'
;; selector is the same as the one shown above.

(load "/home/lucec/classes/sicp/chapter-2/section-1/interval.scm")

;; (make-center-percent 5 0.1) should yield the interval
;; (5-0.5, 5+0.5) = (4.5, 5.5)
(define (make-center-percent c p)
  (make-center-width c (* c p)))

(define (percent i)
  (/ (width i) (center i)))

(make-center-percent 5 0.1)
(percent (make-center-percent 5 0.1))
