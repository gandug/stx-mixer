;; ------------------------------------------------------------
;; Contract: stx-mixer
;; Purpose: Simple STX mixer for on-chain transaction privacy
;; Mechanism: Commit-reveal based deposit and withdraw
;; Author: [Your Name]
;; ------------------------------------------------------------

(define-constant MIX_AMOUNT u1000000) ;; 1 STX per deposit
(define-constant ERR_ALREADY_USED (err u100))
(define-constant ERR_INVALID_SECRET (err u101))
(define-constant ERR_NOT_ENOUGH_FUNDS (err u102))

;; Store used secrets to prevent double withdrawals
(define-map used-secrets (buff 32) bool)

;; === Deposit with a commitment ===
(define-public (deposit (commitment (buff 32)))
  (begin
    (asserts! (is-none (map-get? used-secrets commitment)) ERR_ALREADY_USED)
    (asserts! (is-eq (stx-transfer? MIX_AMOUNT tx-sender (as-contract tx-sender)) (ok true)) ERR_NOT_ENOUGH_FUNDS)
    ;; Commitment stored but not linked to sender
    (map-set used-secrets commitment false)
    (ok true)
  )
)

;; === Withdraw to a new address using secret ===
(define-public (withdraw (secret (buff 32)) (recipient principal))
  (let ((commitment (sha256 secret)))
    (begin
      (match (map-get? used-secrets commitment)
        value
        (if (is-eq value false)
          (begin
            (map-set used-secrets commitment true)
            (stx-transfer? MIX_AMOUNT (as-contract tx-sender) recipient)
          )
          ERR_ALREADY_USED
        )
        ERR_INVALID_SECRET
      )
    )
  )
)

;; === Read-only to check if a secret is used ===
(define-read-only (is-secret-used (commitment (buff 32)))
  (default-to false (map-get? used-secrets commitment))
)
