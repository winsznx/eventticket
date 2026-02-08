;; EventTicket - Blockchain ticketing
(define-constant ERR-SOLD-OUT (err u100))
(define-constant ERR-NOT-OWNER (err u101))

(define-map tickets
    { ticket-id: uint }
    { event-id: uint, owner: principal, price: uint, used: bool }
)

(define-map events { event-id: uint } { supply: uint, price: uint })
(define-data-var ticket-counter uint u0)

(define-public (create-event (event-id uint) (supply uint) (price uint))
    (begin
        (map-set events { event-id: event-id } { supply: supply, price: price })
        (ok true)
    )
)

(define-public (mint-ticket (event-id uint))
    (let (
        (event-info (unwrap! (map-get? events { event-id: event-id }) ERR-SOLD-OUT))
        (ticket-id (var-get ticket-counter))
    )
        (asserts! (> (get supply event-info) u0) ERR-SOLD-OUT)
        (map-set tickets { ticket-id: ticket-id } { event-id: event-id, owner: tx-sender, price: (get price event-info), used: false })
        (map-set events { event-id: event-id } (merge event-info { supply: (- (get supply event-info) u1) }))
        (var-set ticket-counter (+ ticket-id u1))
        (ok ticket-id)
    )
)

(define-read-only (get-ticket (ticket-id uint))
    (map-get? tickets { ticket-id: ticket-id })
)
