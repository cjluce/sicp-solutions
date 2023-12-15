;; *Exercise 2.3:* Implement a representation for rectangles in a
;; plane.  (Hint: You may want to make use of *Note Exercise 2-2::.)  In
;; terms of your constructors and selectors, create procedures that
;; compute the perimeter and the area of a given rectangle.  Now
;; implement a different representation for rectangles.  Can you
;; design your system with suitable abstraction barriers, so that the
;; same perimeter and area procedures will work using either
;; representation?

(load "/home/lucec/classes/sicp/chapter-2/section-1/ex-2.02.scm")

;; (define s (make-segment (make-point 1 1) (make-point 2 2)))
;; (print-point (midpoint-segment s))

(define (area-rectangle r) (* (width-rectangle r) (height-rectangle r)))
(define (perimeter-rectangle r) (+ (* 2 (width-rectangle r))
				   (* 2 (height-rectangle r))))

;; two points (bot left, top right)
(define (width-rectangle r) (- (x-point (cdr r)) (x-point (car r))))
(define (height-rectangle r) (- (y-point (cdr r)) (y-point (car r))))
(define (make-rectangle p1 p2)
  (cons p1 p2))
(perimeter-rectangle (make-rectangle (make-point 0 0) (make-point 1 1)))
(area-rectangle (make-rectangle (make-point 0 0) (make-point 1 1)))

(define (width-rectangle r) (car (cdr r)))
(define (height-rectangle r) (cdr (cdr r)))
(define (make-rectangle x y w h)
  (cons (make-point x y) (cons w h)))
(perimeter-rectangle (make-rectangle 0 0 1 1))
(area-rectangle (make-rectangle 0 0 1 1))
