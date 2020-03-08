#lang racket

;----------------------------------------------------------------------------------------------------------------------------

;Defining the sum function
(define (sum Lst)
  (cond
    ;If the list is empty, return 0
    [(null? Lst) 0]
    ;Else return the first value plus the sum of the remaining elements
    [else (+ (car Lst) (sum (cdr Lst)))]
  )
)

;Test Cases

;(sum '(1 2 3))
;6

;(sum '(4 5 6))
;15

;----------------------------------------------------------------------------------------------------------------------------

;Defining the desc? function
(define (desc? Lst)
  (cond
    ;If the list is empty, or has one element, return true
    [(or (null? Lst) (null? (cdr Lst))) #t]
    ;Else...
    [else
      (cond
        ;If the first element is greater than the second element, return the value of is the cdr of the list is descending
        [(> (car Lst) (car (cdr Lst))) (desc? (cdr Lst))]
        ;Else return false
        [else #f]
      )
    ]
  )
)

;Test Cases

;(desc? '(89 87 65 45))
;#t

;(desc? '(89 87 65 79))
;#f

;(desc? '(12))
;#t

;(desc? '())
;#t