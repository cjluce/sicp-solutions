#lang sicp

;; *Exercise 2.32:* We can represent a set as a list of distinct
;; elements, and we can represent the set of all subsets of the set as
;; a list of lists.  For example, if the set is `(1 2 3)', then the
;; set of all subsets is `(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2
;; 3))'.  Complete the following definition of a procedure that
;; generates the set of subsets of a set and give a clear explanation
;; of why it works:

(define (display-object desc obj)
  (display desc)
  (display obj)
  (newline))

(define (subsets s)
  (display-object "Subset: " s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (display-object "Rest: " rest)
        (display-object "Car: " (car s))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(subsets '(1 2 3))

;; This works essentially in reverse order (because of building on the
;; call stack). Subsets is called until s is equal to nil, and it
;; returns the list containing nil. This is the first result passed to
;; rest. We then (working at the top of the stack), have a (car s)
;; equal to whatever the last value of the list was. We cons that car
;; onto each value of rest, and then append that to the orignal rest
;; list. The first call of this will result in: (() (3)). That list is
;; then passed to the next value of rest on the call stack. I will do
;; one more iteration in text. The next car will be 2. Rest is equal
;; to (() (3)) (from the previous top of the call stack). We cons 2
;; onto each element of rest: ((2) (2 3)), and then append the
;; original rest: (() (3) (2) (2 3)). This is then popped off of the
;; call stack and handed to the next rest call.

;; Notice how we are building this in reverse order, each time
;; creating all subsets. I.e., given (3), all subsets are: ((3)
;; ()). Given (2 3), all subsets are: (() (3) (2) (2 3)), etc. And
;; this result is handed to the next call of defining rest, to which
;; we add one more element.

;; (define (tst x) (pair? x))

;; (#%provide (all-defined))
