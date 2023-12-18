;; *Exercise 2.11:* In passing, Ben also cryptically comments: "By
;; testing the signs of the endpoints of the intervals, it is possible
;; to break `mul-interval' into nine cases, only one of which requires
;; more than two multiplications."  Rewrite this procedure using Ben's
;; suggestion.

(define (mul-interval-1 x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (mul-interval-2 x y)
  ;; (a1, a2) * (b1, b2)
  (let ((a1 (lower-bound x))
	(a2 (upper-bound x))
	(b1 (lower-bound y))
	(b2 (upper-bound y)))
    (cond ((positive? a1)
	   (cond ((positive? b1) (make-interval (* a1 b1) (* a2 b2)))
		 ((negative? b2) (make-interval (* a2 b1) (* a1 b2)))
		 ((and (negative? b1) (positive? b2)) (make-interval (* a2 b1) (* a2 b2)))))
	  ((negative? a2)
	   (cond ((positive? b1) (make-interval (* a1 b2) (* a2 b1)))
		 ((negative? b2) (make-interval (* a2 b2) (* a1 b1)))
		 ((and (negative? b1) (positive? b2)) (make-interval (* a1 b2) (* a1 b1)))))
	  ((and (negative? a1) (positive? a2))
	   (cond ((positive? b1) (make-interval (* a1 b2) (* a2 b2)))
		 ((negative? b2) (make-interval (* a2 b1) (* a1 b1)))
		 ((and (negative? b1) (positive? b2)) (make-interval (min (* a1 b2) (* a2 b1))
								     (max (* a1 b1) (* a2 b2)))))))))

;; a1 > 0
(let ((x (make-interval 2 3))
      (y (make-interval 2 3)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

(let ((x (make-interval 2 3))
      (y (make-interval -3 -2)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

(let ((x (make-interval 2 3))
      (y (make-interval -2 3)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

;; a2 < 0
(let ((x (make-interval -3 -2))
      (y (make-interval 2 3)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

(let ((x (make-interval -3 -2))
      (y (make-interval -3 -2)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

(let ((x (make-interval -3 -2))
      (y (make-interval -2 3)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

;; a1 < 0 and a2 > 0
(let ((x (make-interval -2 3))
      (y (make-interval 2 3)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

(let ((x (make-interval -2 3))
      (y (make-interval -3 -2)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))

(let ((x (make-interval -2 3))
      (y (make-interval -2 3)))
  (=-interval (mul-interval-1 x y) (mul-interval-2 x y)))
