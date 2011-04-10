(define (make-account balance)
  (let ((init-balance balance)
	(transactions nil))
    (define (withdraw amount)
      (if (>= balance amount)
	  (begin (set! balance (- balance amount))
		 (record 'withdraw amount)
		 ;;(set! transactions (cons transactions (list 'withdraw amount)))
		 balance)
	  "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      ;;(set! transactions (cons transactions (list 'deposit amount)))
      (record 'deposit amount)
      balance)
    (define (record m amount)
      (if (null? transactions) (set! transactions (list m amount))
	  (set! transactions (list transactions (list m amount)))))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    ((eq? m 'balance) balance)
	    ((eq? m 'init-balance) init-balance)
	    ((eq? m 'transactions) transactions)
	    (else (error "Unknown request -- MAKE-ACCOUNT"
			 m))))
    dispatch))