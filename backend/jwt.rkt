#lang racket

(require net/jwt)

(provide make-jwt
         token-identity
         token-id
         token-email
         verify)

(define secret "%a6&7>L^g5K8:h9C3@4Y5W#3")
(define alg "HS256")
(define iss "eshop-webapi-racket")

; email : string?
; identity, 身分別 : number?, 0:member, 1:administrator
(define (make-jwt id email [identity 0])
  (encode/sign alg secret
               #:iss iss
               #:sub email
               #:exp (+ (current-seconds) 86400)
               #:other (hash 'identity identity
                             'id id)))

(define (verify jwt)
  (decode/verify jwt
                 alg secret
                 #:iss iss))

(define (token-identity jwt)
  (claims-ref (decode-jwt jwt) 'identity))

(define (token-id jwt)
  (claims-ref (decode-jwt jwt) 'id))

(define (token-email jwt)
  (subject (decode-jwt jwt)))

