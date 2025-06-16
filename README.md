 stx-mixer

**Privacy-Preserving STX Mixer Smart Contract for Stacks Blockchain**

---

 Overview

`stx-mixer` is a privacy-focused smart contract built on the Stacks blockchain that allows users to anonymize their STX token transactions. The contract implements a basic mixing mechanism where users deposit STX tokens into a pool and later withdraw them anonymously using cryptographic commitments.

This contract is designed to help improve user privacy by breaking the on-chain link between sender and receiver addresses.

---

 Features

-  Deposit STX into a mixing pool
-  Generate unique secret commitments for deposits
-  Withdraw STX anonymously by submitting a valid secret
-  Prevent double-spending through nullifier tracking
-  Read-only verification of commitment existence and withdrawal status

---

 Smart Contract Functionality

- **deposit (commitment)**
  - Accepts a cryptographic commitment representing a secret and stores it on-chain.
  - Users deposit a fixed amount of STX for each commitment.

- **withdraw (secret, nullifier)**
  - Allows a user to withdraw STX by submitting a valid secret that matches a stored commitment.
  - Prevents double-withdrawals using nullifier records.

- **read-only functions**
  - Verify if a commitment exists.
  - Check if a nullifier has been used.

---

 Use Cases

- Privacy-preserving transfers
- Anonymous payments
- Donation systems
- Private DAOs and voting systems (future extensions)

---


