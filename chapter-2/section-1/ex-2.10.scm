;; *Exercise 2.10:* Ben Bitdiddle, an expert systems programmer, looks
;; over Alyssa's shoulder and comments that it is not clear what it
;; means to divide by an interval that spans zero.  Modify Alyssa's
;; code to check for this condition and to signal an error if it
;; occurs.

(load "/home/lucec/classes/sicp/chapter-2/section-1/interval.scm")

(define (div-interval x y)
  (if (and (< (lower-bound y) 0)
	   (> (upper-bound y) 0))
      (error "Cannot divide by an interval that spans zero.")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
				   (/ 1.0 (lower-bound y))))))
