#lang sicp

(#%require sicp-pict)

;; painters
(paint einstein)
(paint (escher))
(paint mark-of-zorro)

;; procedures 
(paint (beside mark-of-zorro mark-of-zorro))
(paint (below mark-of-zorro mark-of-zorro))
(paint (flip-vert mark-of-zorro))
(paint (flip-horiz mark-of-zorro))
