#lang racket
(require rackunit)

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
             (filter (check-monotonic prev-D (D-less-eq? (- n 1))
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

(define check-monotonic
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
  (check-eq? (check-fun f D0 D0) #t))
(for ([f D2])
  (check-eq? (check-fun f D1 D1) #t))

(define embed
  (lambda (n)
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
    (cond [(equal? n 0)
           (lambda (d)
             (app d 'bot))]
          [else
           (lambda (d)
             (map (lambda (x)
                    (cons x ((project (- n 1)) (app d ((embed (- n 1)) x)))))
                  (D n)))])))

(define d0 ((embed 0) 'bot))
(define d1 '((bot . bot) (top . top)))
(define d2 ((embed 0) 'top))

(check-eq? ((project 0) ((embed 0) 'bot)) 'bot)
(check-eq? ((project 0) ((embed 0) 'top)) 'top)


(check-eq? (check-fun ((embed 1) d1) D1 D1) #t)

; todo: fix bug
;((project 1) ((embed 1) d1))