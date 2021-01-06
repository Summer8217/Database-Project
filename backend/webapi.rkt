#lang racket

(require web-server/http
         web-server/servlet-env
         web-server/http/bindings
         web-server/dispatch
         net/url
         net/base64
         file/convertible
         "jwt.rkt"
         pict
         json
         db
         "weblib.rkt")

; read the user and password of db connection
(define user-info (file->lines "db-userinfo.txt"))

; connect db
(define DB
  (mysql-connect
   #:port 3306
   #:database "eshop"
   #:user (list-ref user-info 0)
   #:password (list-ref user-info 1)))

; search-results->json: (listof vector) -> bytes
; return a json source byte string
(define (search-results->json rows)
  (let ([products (map (λ (row)
                         (hash 'id (vector-ref row 0)
                               'name (vector-ref row 1)
                               'type (vector-ref row 2)
                               'price (vector-ref row 3)
                               'image (bytes->string/utf-8 (vector-ref row 4))))
                       rows)])
    (jsexpr->bytes
     (hash 'amount (length products)
           'products products))))

;
(define (search req str)
  (my-response
   #:body (search-results->json
           (query-rows
            DB
            (format
             "select id, name, type, price, image from merchandises where name like '%~a%'" str)))
   #:mime "application/json"))

(define (get-all req)
  (my-response #:body (search-results->json
                       (query-rows DB "select id, name, type, price, image from merchandises;"))
               #:mime "application/json"))

; id : string?
(define (merchandise req id)
  (define query
    (query-row
     DB
     (format "select id, name, price, type, detail_info, image from merchandises where id=~a;" id)))
  (my-response
   #:body (jsexpr->bytes
           (hash 'id (vector-ref query 0)
                 'name (vector-ref query 1)
                 'price (vector-ref query 2)
                 'merchandise_type (vector-ref query 3)
                 'detail_info (vector-ref query 4)
                 'image (bytes->string/utf-8 (vector-ref query 5))))
   #:mime "application/json"))

(define (login req)
  ; extract email and password
  (define bindings (request-bindings req))
  (define email (extract-binding/single 'email bindings))
  (define password (extract-binding/single 'password bindings))

  ; validation
  (define message "successful")
  (define token #f)
  (define query (query-rows DB
                            (format "select id, email, password from members where email='~a';"
                                    email)))
  (if (null? query)
      (set! message "不存在此帳戶")
      (if (string=? (vector-ref (list-ref query 0) 2)
                    password)
          (set! token (make-jwt (vector-ref (list-ref query 0) 0) email))
          (set! message "錯誤的密碼")))
  
  (my-response
   #:body
   (jsexpr->bytes
    (hash 'message message
          'token token
          'identity (if token
                        (token-identity token)
                        #f)))
   #:mime "application/json"))

(define (login-admin req)
  ; extract email and password
  (define bindings (request-bindings req))
  (define email (extract-binding/single 'email bindings))
  (define password (extract-binding/single 'password bindings))

  ; validation
  (define message "successful")
  (define token #f)
  (define query (query-rows DB
                            (format "select id, email, password from administrators where email='~a';"
                                    email)))
  (if (null? query)
      (set! message "不存在此帳戶")
      (if (string=? (vector-ref (list-ref query 0) 2)
                    password)
          (set! token (make-jwt (vector-ref (list-ref query 0) 0) email 1))
          (set! message "錯誤的密碼")))
  
  (my-response
   #:body
   (jsexpr->bytes
    (hash 'message message
          'token token
          'identity (if token
                        (token-identity token)
                        #f)))
   #:mime "application/json"))

(define (login-check req)
  (let ([jwt (hash-ref (bytes->jsexpr (request-post-data/raw req)) 'token)])
    (if (verify jwt)
        (my-response
         #:body (jsexpr->bytes
                 (hash 'id (token-id jwt)
                       'email (token-email jwt)
                       'identity (token-identity jwt)))
         #:mime "application/json")
        (my-response
         #:body (jsexpr->bytes
                 (hash 'id #f
                       'email #f
                       'identity #f))
         #:mime "application/json"))))

; headers : (listof (cons symbol string))
; ref : symbol
(define (headers-ref headers ref)
  (if (null? headers)
      "not found"
      (if (symbol=? (caar headers) ref)
          (cdar headers)
          (headers-ref (cdr headers) ref))))

; 
(define (add-to-cart req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define merchandise (bytes->jsexpr (request-post-data/raw req)))
         (define merchandise_id (hash-ref merchandise 'merchandise_id))
         (define quantity (hash-ref merchandise 'quantity))
         (define uid (token-id token))
         
         (query-exec
          DB
          (string-append
           "insert into has (cart_id, merchandise_id, quantity) "
           (format "values (~a,~a,~a) " uid merchandise_id quantity)
           (format "on duplicate key update quantity=quantity+~a; " quantity)))
         
         (query-exec
          DB
          (format "update merchandises set amount=amount-~a where id=~a and amount>=~a;"
                  quantity merchandise_id quantity))
         
         (my-response)]
        [else (unauthorized)])))

(define (update-merchandise-quantity req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (define data (bytes->jsexpr (request-post-data/raw req)))
         (define mid (hash-ref data 'id))
         (define quantity (hash-ref data 'quantity))
         (query-exec
          DB
          (format "update has set quantity=~a where cart_id=~a and merchandise_id=~a;"
                  quantity uid mid))
         (my-response)]
        [else
         (unauthorized)])))

(define (delete-merchandise req id)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (query-exec
          DB
          (format "delete from has where cart_id=~a and merchandise_id=~a;" uid id))
         (my-response)]
        [else
         (unauthorized)])))

(define (get-cart req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (define cart
           (query-rows
            DB
            (string-append
             "select id, name, price, quantity from merchandises, has where "
             (format "cart_id=~a and id=merchandise_id and id in (select merchandise_id from has where cart_id=~a);" uid uid))))
         (my-response
          #:body
          (jsexpr->bytes
           (map (λ (v) (hash 'merchandise_id (vector-ref v 0)
                             'name (vector-ref v 1)
                             'price (vector-ref v 2)
                             'quantity (vector-ref v 3)))
                cart))
          #:mime "application/json")]
        [else
         (unauthorized)])))

; helper function
(define (calc-total-price original code)
  (cond
    [code
     ; unavaliable
     (query-exec
      DB
      (format "update coupons set avaliable=0 where code=~a;" code))
     (define type (query-value DB (format "select type from coupons where code=~a;" code)))
     (define content (query-value DB (format "select content from coupons where code=~a;" code)))
     (if (string=? type "折扣")
         (* original content 1/100)
         (- original content))]
    [else original]))

(define (place-order req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (define data (bytes->jsexpr (request-post-data/raw req)))
         (define shipping-type (hash-ref data 'shipping_type))
         (define payment-type (hash-ref data 'payment_type))
         (define coupon-code (hash-ref data 'coupon_code))
         (define products (hash-ref data 'products))
         (define oid
           (let ([id (query-rows DB "select id from orders order by id desc limit 1;")])
             (if (null? id) 1 (+ 1 (vector-ref (list-ref id 0) 0)))))
         (define total-price
           (let ([original (apply + (map
                                   (λ (product) (* (hash-ref product 'quantity) (hash-ref product 'price)))
                                   products))])
             (calc-total-price original coupon-code)))

         ; insert an order to orders
         (query-exec
          DB
          (format "insert into orders values (~a,~a,'~a','~a','~a',~a,NOW(),~a);"
                  oid uid shipping-type payment-type "訂單成立" total-price (if coupon-code coupon-code "null")))

         ; insert id & quantity to includes
         (for ([product products])
           (query-exec
            DB
            (format "insert into includes values (~a,~a,~a);"
                    oid (hash-ref product 'merchandise_id) (hash-ref product 'quantity))))
         ; Empty the cart of id
         (query-exec
          DB
          (format "delete from has where cart_id=~a" uid))
         
         (my-response)]
        [else
         (unauthorized)])))

(define (get-orders req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (define query
           (query-rows
            DB
            (format "select id,shipping_type,payment_type,status,total_price, DATE_FORMAT(date, '%Y %m %d') from orders where member_id=~a;" uid)))
         (my-response
          #:body
          (jsexpr->bytes
           (map (λ (v) (hash 'id (vector-ref v 0)
                             'shipping_type (vector-ref v 1)
                             'payment_type (vector-ref v 2)
                             'status (vector-ref v 3)
                             'total_price (vector-ref v 4)
                             'date (vector-ref v 5)
                             'products (map (λ (x) (hash 'merchandise_id (vector-ref x 0)
                                                         'name (vector-ref x 1)
                                                         'quantity (vector-ref x 2)
                                                         'type (vector-ref x 3)
                                                         'price (vector-ref x 4)))
                                            (query-rows
                                             DB
                                             (format
                                              "select merchandise_id, name, quantity, type, price from includes, merchandises M where order_id=~a and merchandise_id=M.id;"
                                              (vector-ref v 0))))))
                query))
          #:mime "application/json")]
        [else (unauthorized)])))

(define (get-coupon req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (define query
           (query-rows
            DB
            (format "select code, type, content from coupons where member_id=~a and avaliable=1 and to_days(now())<to_days(expiration_date);" uid)))
            
         (my-response
          #:body
          (jsexpr->bytes
           (map (λ (v) (hash 'code (format "~a-~a"
                                           (vector-ref v 0)
                                           (if (string=? (vector-ref v 1) "折扣")
                                               (format "~a折" (vector-ref v 2))
                                               (format "折抵~a元" (vector-ref v 2))))
                             'type (vector-ref v 1)
                             'content (vector-ref v 2)))
                query))
          #:mime "application/json")]
        [else
         (unauthorized)])))

(define (user req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 0))
         (define uid (token-id token))
         (define query
           (query-row
            DB
            (format "select id, name, nickname, email from members where id = ~a;" uid)))
         (my-response
          #:body
          (jsexpr->bytes
           (hash 'id (vector-ref query 0)
                 'name (vector-ref query 1)
                 'nickname (vector-ref query 2)
                 'email (vector-ref query 3)))
          #:mime "application/json")]
        [else (unauthorized)])))

(define (add-merchandise req)
  (define token (headers-ref (request-headers req) 'authorization))
  (if (string=? token "not found")
      (unauthorized)
      (cond
        [(and (verify token) (= (token-identity token) 1))
         (define bindings (request-bindings req))
         (define image (extract-binding/single 'merchandiseimage bindings))
         (define name (extract-binding/single 'merchandisename bindings))
         (define desc (extract-binding/single 'merchandisedescription bindings))
         (define type (extract-binding/single 'merchandisetype bindings))
         (define price (extract-binding/single 'merchandiseprice bindings))
         (define amount (extract-binding/single 'merchandisequantity bindings))
         (define id (+ 1 (query-value DB "select id from merchandises order by id desc limit 1;")))
         (query-exec
          DB
          (format "insert into merchandises values (~a, '~a', ~a, '~a', ~a, '~a', '~a', 1);"
                  id name price desc amount image type))
         (my-response)]
        [else (unauthorized)])))
         
(define (register req)
  (define bindings (request-bindings req))
  (define name (extract-binding/single 'membername bindings))
  (define nickname (extract-binding/single 'membernickname bindings))
  (define address (extract-binding/single 'memberaddress bindings))
  (define phone (extract-binding/single 'memberphone bindings))
  (define email (extract-binding/single 'memberemail bindings))
  (define password (extract-binding/single 'memberpassword bindings))
  (define last-id (query-value DB "select id from members order by id desc limit 1;"))

  (query-exec
   DB
   (format "insert into members values (~a,'~a','~a','~a','~a','~a', '~a',~a);"
           (+ last-id 1) name nickname address phone email password 1))

  (my-response))

(define (welcome req)
  (response/xexpr
   `(html (head (title "Web API"))
          (h1 "welcome to web api"))))

(define-values (go _)
  (dispatch-rules
   [("search" (string-arg)) #:method "get" search]
   [("get-all") #:method "get" get-all]
   [("login") #:method "post" login]
   [("login-admin") #:method "post" login-admin]
   [("login-check") #:method "post" login-check]
   [("add-to-cart") #:method "post" add-to-cart]
   [("get-cart") #:method "get" get-cart]
   [("merchandise" (string-arg)) #:method "get" merchandise]
   [("user") #:method "get" user]
   [("register") #:method "post" register]
   [("update-merchandise-quantity") #:method "put" update-merchandise-quantity]
   [("delete-merchandise" (string-arg)) #:method "delete" delete-merchandise]
   [("get-coupon") #:method "get" get-coupon]
   [("place-order") #:method "post" place-order]
   [("add-merchandise") #:method "post" add-merchandise]
   [("get-orders") #:method "get" get-orders]
   [else welcome]))

; start the server
(display "The web api server is running...\n")
(serve/servlet
 go
 #:servlet-path "/"
 #:port 3000
 #:servlet-regexp #rx""
 #:command-line? #t
 #:listen-ip #f)





