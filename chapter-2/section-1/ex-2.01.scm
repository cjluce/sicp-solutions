;; *Exercise 2.1:* Define a better version of `make-rat' that handles
;; both positive and negative arguments.  `Make-rat' should normalize
;; the sign so that if the rational number is positive, both the
;; numerator and denominator are positive, and if the rational number
;; is negative, only the numerator is negative.

(load "/home/lucec/classes/sicp/chapter-2/section-1/rat.scm")

(define (make-rat n d)
  (let* ((sign (if (< (* n d) 0) -1 1))
         (n (abs n))
         (d (abs d))
         (g (gcd n d)))
    (cons (* sign (/ n g)) (/ d g))))

