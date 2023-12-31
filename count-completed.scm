(import (chicken file)
	(chicken irregex)
	(chicken string)
	(chicken base)
	(chicken format)
	(chicken sort)
	srfi-1)

(define n-chapters 5)
(define n-exercises-by-chapter '((1 . 46) (2 . 97) (3 . 82) (4 . 79) (5 . 52)))
(define n-exercises (let loop ((lst (map cdr n-exercises-by-chapter))
			       (sum 0))
		      (if (null? lst) sum (loop (cdr lst) (+ sum (car lst))))))

(define (get-n-exercises chapter)
  (alist-ref chapter n-exercises-by-chapter))

(define solved-exercises-files
  (find-files "." #:test
	      (lambda (x)
		(irregex-search (glob->sre "ex-*") x))))

;; structure of file split looks like (. chapter-1 section-2 ex-1.16.scm)
(define solved-exercises
  (let ((data '()))
    (for-each (lambda (file)
		;; split up the file string, and reference the parts
		(let* ((file-split (string-split file "/"))
		       (chapter-raw (list-ref file-split 1))
		       (section-raw (list-ref file-split 2))
		       (problem-raw (list-ref file-split 3))
		       (chapter (string->number
				 (substring chapter-raw (+ 1 (substring-index "-" chapter-raw)))))
		       (section (string->number
				 (substring section-raw (+ 1 (substring-index "-" section-raw)))))
		       (problem (string->number
				 (list-ref (string-split problem-raw ".") 1))))
		  ;; this is a nested json-like structure... so it looks
		  ;; ((chapter ((section problems) (section problems)))
		  ;;  (chapter ((section problems))))
		  ;; if the chapter exists, append to the section, else, add the chapter
		  (let ((chap-entry (alist-ref chapter data)))
		    (if chap-entry
			(let ((sec-entry (alist-ref section chap-entry)))
			  (if sec-entry
			      (begin
				(set! chap-entry (alist-update section (cons problem sec-entry) chap-entry))
				(set! data (alist-update chapter chap-entry data)))
			      (begin
				(set! chap-entry (alist-update section (list problem) chap-entry))
				(set! data (alist-update chapter chap-entry data)))))
			(begin
			  (set! data (alist-update chapter (list (cons section (list problem))) data)))))))
	      solved-exercises-files)
    ;; sort the data in each section
    ;; i think that this the chapters themselves are in sorted order
    (set! data
      (map (lambda (chapter-lst)
	     ;; add the chapter back to the front
	     (cons (car chapter-lst)
		   ;; sort within the section list
		   (map (lambda (section-lst)
			  (cons (car section-lst) (sort (cdr section-lst) <)))
			;; sort exercises over the sections in sorted order!
			(sort (cdr chapter-lst) (lambda (x y) (< (car x) (car y)))))))
	   data))
    data))

(define (get-solved-exercises-for-chapter chapter)
  (let ((chap-entry (alist-ref chapter solved-exercises))
	(n-solved 0))
    (when chap-entry
      (for-each (lambda (section-alist)
		  (set! n-solved (+ n-solved (length (cdr section-alist)))))
		chap-entry))
    n-solved))

(define solved-exercises-by-chapter
  (let loop ((chapter 1)
	     (solved '()))
    (if (> chapter n-chapters)
	solved
	(loop (+ chapter 1)
	      (cons (cons chapter (get-solved-exercises-for-chapter chapter))
		    solved)))))

(define (get-share x y)
  (/ (round (* 1000.0 (/ x y))) 10.0))

(define (share-solved-for-chapter chapter)
  (let ((total (alist-ref chapter n-exercises-by-chapter))
	    (solved (alist-ref chapter solved-exercises-by-chapter)))
    ;;(round (* 100.0 (/ solved total)))
    (get-share solved total)
    ))


(define (solved-exercise-list-by-chapter chapter)
  (let ((section-lst (alist-ref chapter solved-exercises)))
    (if section-lst
	(apply append (map (lambda (x) (cdr x)) section-lst))
	'())))

(define (solved-visualization-by-chapter chapter)
  (let* ((solved-lst (solved-exercise-list-by-chapter chapter))
	 (total-exercises (get-n-exercises chapter))
	 (ret-string (make-string total-exercises #\-)))
    (do ((i 1 (+ i 1)))
	((> i total-exercises) ret-string)
      (cond ((null? solved-lst))
	    ((= (car solved-lst) i)
	     (string-set! ret-string (- i 1) #\+)
	     (set! solved-lst (cdr solved-lst)))))))

(let ((total-solved 0))
  (for-each (lambda (chapter)
	      (set! total-solved (+ total-solved (get-solved-exercises-for-chapter chapter)))
	      (printf "Chapter ~A: ~A%: ~A~N"
		      chapter
		      (share-solved-for-chapter chapter)
		      (solved-visualization-by-chapter chapter)))
	    '(1 2 3 4 5))
  (printf "Total: ~A%~N"
          ;; (round (* 100.0 (/ total-solved n-exercises)))
          (get-share total-solved n-exercises)
          ))
