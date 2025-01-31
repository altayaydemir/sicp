#lang sicp

; ex-2.7: implement make-interval, upper-bound and lower-bound procedures

(define (make-interval a b) (cons a b))

(define (lower-bound interval)
  (let ((a (car interval)) (b (cdr interval)))
    (if (< a b) a b)))

(define (upper-bound interval)
  (let ((a (car interval)) (b (cdr interval)))
    (if (< a b) b a)))

; pre-defined procedures from ch-2.1.4
(define (add-interval x y)
  (make-interval
   (+ (lower-bound x) (lower-bound y))
   (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval
     (min p1 p2 p3 p4)
     (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
   x (make-interval (/ 1.0 (upper-bound y))
                    (/ 1.0 (lower-bound y)))))

; test
(upper-bound (make-interval 5 5)) ; 5
(upper-bound (make-interval 5 2)) ; 5
(lower-bound (make-interval 2 5)) ; 2