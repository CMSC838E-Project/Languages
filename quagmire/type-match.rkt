#lang racket
(provide Listof Vectorof Union ann)

(struct Listof (t))
(struct Vectorof (t))
(struct Union (t1 t2))

(define (ann v t)
  (match t
    ['Integer (integer? v)]
    ['Character (char? v)]
    ['String (string? v)]
    ['Any #t]
    [(Listof t) (or (empty? v)
                    (and (cons? v)
                         (ann (car v) t)
                         (ann (cdr v) (Listof t))))]
    [(Vectorof t) (and (vector? v)
                       (matches-vector v t 0))]
    [(Union t1 t2) (or (ann v t1)
                       (ann v t2))]))

(define (matches-vector v t i)
  (if (< i (vector-length v))
      (and (ann (vector-ref v i) t)
           (matches-vector v t (add1 i)))
      #t))