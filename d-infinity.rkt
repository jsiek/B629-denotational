#lang racket
(require rackunit)
(require racket/match)

(define app
  (lambda (f x)
    (cond [(assoc x f) => cdr]
          [else
           (error 'bad-app "argument ~s not found in ~s" x f)])))
;    (cdr (assoc x f))))

(define build-function
  (lambda (dom rng)
    (cond [(null? dom) (list '())]
          [else
           (let ([x (car dom)])
             (for*/list ([y rng]
               [f (build-function (cdr dom) rng)])
                 (cons (cons x y) f)))])))

(define D
  (lambda (n)
    (cond [(equal? n 0)
           '(bot top)]
          [else
           (let ([prev-D (D (- n 1))])
             (filter (monotonic? prev-D (D-less-eq? (- n 1))
                                      (D-less-eq? (- n 1)))
                     (build-function prev-D prev-D)))])))

(define pointwise-less-eq?
  (lambda (rng-less-eq? dom)
    (lambda (f g)
      (for/and ([d dom])
        (rng-less-eq? (app f d) (app g d))))))

(define D-less-eq?
  (lambda (n)
    (cond [(equal? n 0)
           (lambda (a b)
             (or (and (eq? a 'bot) (eq? b 'top))
                 (eq? a b)))]
          [else
           (let ([rng-less-eq? (D-less-eq? (- n 1))])
             (pointwise-less-eq? rng-less-eq? (D (- n 1))))])))

(define D-join
  (lambda (n)
    (cond [(equal? n 0)
           (lambda (a b)
             (match `(,a ,b)
               [`(top top) 'top]
               [`(top bot) 'top]
               [`(bot top) 'top]
               [`(bot bot) 'bot]))]
          [else
           (lambda (f g)
             (let ([D-join-prev (D-join (- n 1))])
             (for/list ([d (D (- n 1))])
               (cons d (D-join-prev (app f d) (app g d))))))])))

(define D-inf-join
  (lambda (d1 d2)
    (for/list ([n '(0 1 2)])
      ((D-join n) (list-ref d1 n) (list-ref d2 n)))))

(define monotonic?
  (lambda (dom dom-less-eq? rng-less-eq?)
    (lambda (f)
      (for/and ([d1 dom])
        (for/and ([d2 dom])
          (cond [(dom-less-eq? d1 d2)
                 (rng-less-eq? (app f d1) (app f d2))]
                [else #t]))))))

(define check-fun
  (lambda (fun dom rng)
    (for/and ([p fun])
      (and (if (member (car p) dom) #t #f)
           (if (member (cdr p) rng) #t #f)))))

;;(display (D 1))(newline)
;;(display (D 2))(newline)
;; (D 3) runs out of memory!
;; (display (D 3))(newline)
(define D0 (D 0))
(define D1 (D 1))
(define D2 (D 2))

(for ([f D1])
  (check-equal? (check-fun f D0 D0) #t))
(for ([f D2])
  (check-equal? (check-fun f D1 D1) #t))

(define embed
  (lambda (n)
    (if (and (< n 2) (<= 0 n)) '() (error 'embed "out of bounds, n = ~s" n))
    (cond [(equal? n 0)
           (lambda (d)
             (map (lambda (x) (cons x d)) (D 0)))]
          [else
           (lambda (d)
             (map (lambda (x)
                    (cons x ((embed (- n 1)) (app d ((project (- n 1)) x)))))
                  (D n)))])))

(define project
  (lambda (n)
    (if (and (< n 2) (<= 0 n)) '() (error 'project "out of bounds, n = ~s" n))
    (cond [(equal? n 0)
           (lambda (d)
             (app d 'bot))]
          [else
           (lambda (d)
             (map (lambda (x)
                    (cons x ((project (- n 1)) (app d ((embed (- n 1)) x)))))
                  (D (- n 1))))])))

(define d0 ((embed 0) 'bot))
(define d1 '((bot . bot) (top . top)))
(define d2 ((embed 0) 'top))

(define d000 ((embed 1) d0))
(define d002 ((embed 1) d1))
(define d012 `((,d0 . ,d0) (,d1 . ,d1) (,d2 . ,d2)))
(define d111 `((,d0 . ,d1) (,d1 . ,d1) (,d2 . ,d1)))
(define d112 `((,d0 . ,d1) (,d1 . ,d1) (,d2 . ,d2)))
(define d222 ((embed 1) d2))

(check-equal? ((project 0) ((embed 0) 'bot)) 'bot)
(check-equal? ((project 0) ((embed 0) 'top)) 'top)

(check-equal? (check-fun ((embed 1) d1) D1 D1) #t)

(check-equal? ((project 1) d000) d0)
(check-equal? ((project 1) d002) d1)
(check-equal? ((project 1) d012) d1)
(check-equal? ((project 1) d111) d0)
(check-equal? ((project 1) d112) d1)
(check-equal? ((project 1) d222) d2)

(check-equal? ((D-join 0) 'bot 'bot) 'bot)
(check-equal? ((D-join 0) 'bot 'top) 'top)
(check-equal? ((D-join 1) d0 d0) d0)
(check-equal? ((D-join 1) d0 d1) d1)
(check-equal? ((D-join 1) d1 d2) d2)
(check-equal? ((D-join 1) d2 d2) d2)
(check-equal? ((D-join 2) d000 d000) d000)
(check-equal? ((D-join 2) d002 d111) d112)

(define project-from-inf
  (lambda (n)
    (lambda (d)
      (list-ref d n))))

(define embed-to-inf
  (lambda (n)
    (lambda (d)
      (for/list ([i '(0 1 2)])
        (cond [(< i n)
               (for/fold ([x d]) ([j (range 0 (- n i))])
                 (values ((project (- n j 1)) x)))]
              [(= i n)
               d]
              [(> i n)
               (for/fold ([x d]) ([j (range 0 (- i n))])
                 (values ((embed (+ n j)) x)))])))))

(check-equal? ((embed-to-inf 0) 'bot) `(bot ,d0 ,d000))
(check-equal? ((embed-to-inf 1) d0) `(bot ,d0 ,d000))

(define abstr
  (lambda (f)
    (foldl D-inf-join `(bot ,d0 ,d000)                                       
     (for/list ([n '(0 1)])
       ;(display n)(newline)
       (let ([dom (D n)])
         ;(pretty-print dom)(newline)
         (let ([g (for/list ([d dom])
                    (let ([d1 ((embed-to-inf n) d)])
                      ;(display 'd1)(display d1)(newline)
                      (let ([d2 (f d1)])
                        ;(display 'd2)(display d2)(newline)
                        (let ([d3 ((project-from-inf n) d2)])
                          ;(display 'd3)(display d3)(newline)
                          (cons d d3)))))])
           ;(pretty-print g)(newline)
           ((embed-to-inf (+ n 1)) g)))))))

(define apply
  (lambda (rator)
    (lambda (rand)
      (foldl D-inf-join `(bot ,d0 ,d000)
             (for/list ([n '(0 1)])
                       ((embed-to-inf n) (app (list-ref rator (+ n 1)) (list-ref rand n))))))))

;; problem 1
(check-equal? (abstr (lambda (x) x)) `(bot ,d1 ,d012))

;; problem 2
(check-equal? (abstr (lambda (d) `(bot ,d1 ,d012))) `(bot ,d0 ,d111))

;; problem 3
(check-equal? (abstr (lambda (d) (abstr (lambda (d2) d)))) `(bot ,d1 ,d002))

;; problem 4
(check-equal? ((apply `(bot ,d1 ,d012)) `(bot ,d1 ,d012)) `(bot ,d1 ,d002))
