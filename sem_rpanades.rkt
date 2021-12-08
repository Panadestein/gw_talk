#lang slideshow

(require slideshow/latex
         slideshow/extras
         slideshow/code
         pict
         pict/face
         racket/draw)

;; Cache directory

(setup-local-latex-cache)

;; Define variables and optional assemblers

(define myblue (make-color 38 124 185 0.38))
(define mybluedark (make-color 38 124 185 1))

(define-values
    (orig-slide-assembler orig-title-assembler orig-font-type orig-font-size)
    (values (current-slide-assembler) (current-titlet) (current-main-font) (current-font-size))
  )

(define title-slide-assembler
  (lambda (s v-sep c)
    (cb-superimpose
     c
     (hc-append (* gap-size 5)
                 (scale (bitmap (build-path "Figures" "en.jpg")) 0.12)
                 (scale (bitmap (build-path "Figures" "aims.png")) 0.12)
                 (scale (bitmap (build-path "Figures" "tua.png")) 0.12))
     )))

(define mod-title
  (lambda (s)
    (colorize (text s (cons 'bold' "Fira Sans") 35)
              mybluedark)))

;; Title slide

(current-slide-assembler title-slide-assembler)
(current-main-font "Fira Sans")
(current-font-size 37)
(set-page-numbers-visible! #t)
(define pnfgr (send the-font-list find-or-create-font 25 'default 'normal 'normal))
(current-page-number-font pnfgr)
(current-page-number-color mybluedark)

(slide
 (cc-superimpose
  (filled-rounded-rectangle (* client-w 0.8) 160 #:color myblue)
  (para #:align 'center "An overview of GW and its applications" "to core level spectroscopy")
  )
 (blank 60)
 (text "Dr. Ramón L. Panadés Barrueta"
             "Fira Sans" 25)
 (blank 90))

;; Outline of the talk

(define outline
  (let ([sub-para (lambda l
                    (para #:width (* 3/4 (current-para-width)) l))])
    (make-outline
     'one "Why is it called GW?"
     (lambda (tag) (sub-para "Overview of Hedin's equations"))

     'two "Practical GW calculations"
     (lambda (tag) (sub-para "The quasiparticle equation"))

     'three "An example core levels application"
     (lambda (tag) (sub-para "Spectral function of the H2O molecule"))

     'four "Further reading and learning"
     (lambda (tag) (sub-para "Online resources and books"))
     )))

;; Slides start here

(current-slide-assembler orig-slide-assembler)
(current-titlet mod-title)
(current-main-font orig-font-type)
(current-font-size orig-font-size)

(outline 'one)

(slide
 #:title "A test slide"
 (t "Hello I am alive")
 (equation "Euler" (colorize ($$"\\int_{-\\infty}^\\infty e^{-x^2}\\,dx") "DarkRed")))

(slide
 (frame (para "There was a time when I cared") #:color "chartreuse" #:line-width 3))

(outline 'two)

(slide
 #:title "Another test"
 (t "Hi"))

(outline 'three)

(slide
 #:title "Another test"
 (t "Hi"))

(outline 'four)

(slide
 #:title "Another test"
 (t "Hi"))
