#lang sicp

;;      *Exercise 2.29:* A binary mobile consists of two branches, a left
;;      branch and a right branch.  Each branch is a rod of a certain
;;      length, from which hangs either a weight or another binary mobile.
;;      We can represent a binary mobile using compound data by
;;      constructing it from two branches (for example, using `list'):

(define (make-mobile left right)
  (list left right))

;;      A branch is constructed from a `length' (which must be a number)
;;      together with a `structure', which may be either a number
;;      (representing a simple weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

;;        a. Write the corresponding selectors `left-branch' and
;;           `right-branch', which return the branches of a mobile, and
;;           `branch-length' and `branch-structure', which return the
;;           components of a branch.

(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

(define m (make-mobile (make-branch 2 (make-mobile (make-branch 1 6)
                                                   (make-branch 3 7)))
                       (make-branch 4 5)))
(left-branch m)
(right-branch m)
(branch-length (left-branch m))
(branch-structure (right-branch m))

;;        b. Using your selectors, define a procedure `total-weight' that
;;           returns the total weight of a mobile.

(define (mobile? structure)
  (pair? structure))

(define (total-weight mobile)
  (if (mobile? mobile)
      (+ (total-weight (branch-structure (left-branch mobile)))
         (total-weight (branch-structure (right-branch mobile))))
      mobile))

(total-weight m)

;;        c. A mobile is said to be "balanced" if the torque applied by
;;           its top-left branch is equal to that applied by its top-right
;;           branch (that is, if the length of the left rod multiplied by
;;           the weight hanging from that rod is equal to the
;;           corresponding product for the right side) and if each of the
;;           submobiles hanging off its branches is balanced. Design a
;;           predicate that tests whether a binary mobile is balanced.

(define (balanced? mobile)
  (if (mobile? mobile)
      (let ((lb (left-branch mobile))
            (rb (right-branch mobile)))
        (and (= (* (branch-length lb) (total-weight (branch-structure lb)))
                (* (branch-length rb) (total-weight (branch-structure rb))))
             (balanced? (branch-structure lb))
             (balanced? (branch-structure rb))))
      #t))

(define m2 (make-mobile (make-branch 2 (make-mobile (make-branch 1 3)
                                                    (make-branch 3 1)))
                        (make-branch 4 2)))


(balanced? m)
(balanced? m2)

;;        d. Suppose we change the representation of mobiles so that the
;;           constructors are

;;                (define (make-mobile left right)
;;                  (cons left right))

;;                (define (make-branch length structure)
;;                  (cons length structure))

;;           How much do you need to change your programs to convert to
;;           the new representation?

;; I would just need to change the selectors, specifically, the
;; cdr-side selectors. We would no longer need to use cadr (so it
;; would be better tbh).
