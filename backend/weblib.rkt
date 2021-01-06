#lang racket

(require web-server/http
         web-server/servlet-env
         web-server/dispatch
	 json)

(provide (all-defined-out))

(define (my-response
	 #:code    [code/kw 200]
	 #:message [message/kw "OK"]
	 #:seconds [seconds/kw (current-seconds)]
	 #:mime    [mime/kw #f]
	 #:headers [headers/kw (list (header (string->bytes/utf-8  "Access-Control-Allow-Origin")
                                             (string->bytes/utf-8  "*")))]
	 #:body    [body/kw empty])
  (define mime
    (cond ((string? mime/kw)
	   (string->bytes/utf-8 mime/kw))
          ((bytes? mime/kw)
           mime/kw)
	  (else
	   #f)))
  (define message
    (cond ((bytes? message/kw)
	   message/kw)
	  ((string? message/kw)
	   (string->bytes/utf-8 message/kw))
          (else
           #f)))
  (define body
    (cond ((string? body/kw)
	   (list (string->bytes/utf-8 body/kw)))
	  ((bytes? body/kw)
	   (list body/kw))
	  ((list? body/kw)
           body/kw)
	  (#t
	   body/kw)))
  (response/full
   code/kw
   message
   seconds/kw
   mime
   headers/kw
   body))

(define (symbolify x)
  (string->symbol (format "~a" x)))

(define (not-allowed req)
  (my-response #:code 405
	    #:message "Method Not Allowed"))

(define (not-found req)
  (my-response #:code 404
	    #:message "Not Found"))

(define (bad-request)
  (my-response #:code 400
            #:message "Bad Request"))

(define (unauthorized)
  (my-response #:code 401
               #:message "Unauthorized, Your token is invalid or expired."))

(define (internal-server-error)
  (my-response #:code 500
            #:message "Internal Server Error"))