# TOS Payment Rail Layer-2 Design (off-chain settlement with on-chain anchors)

**Status:** Draft
**Last Updated:** 2026-02-17
**Scope:** High-throughput payment layer for TOS Agent Network operations
**Target Throughput:** 10,000 TPS on the payment rail
**Trust Model:** Finality and auditability are guaranteed by a permissioned validator set, with periodic withdrawal anchoring to TOS Blockchain

## 1. Purpose

TOS Network is the discovery and execution orchestration layer for agent collaboration.
The Payment Rail is a dedicated settlement substrate inside AgentOS for high-frequency payment traffic.

This design defines how AgentOS settles usage payments in fast internal accounting while preserving secure asset movement on TOS Blockchain.

The core principle:

- Keep all payment-heavy operations inside the Payment Rail.
- Use on-chain transactions only when users withdraw to TOS Blockchain.
- Preserve cryptographic verification for withdraw proofs and execution receipts.

## 2. Why this architecture

A direct one-layer settlement on the TOS chain would force every micro-task payment into consensus throughput limits.
The Payment Rail decouples frequency from security anchor:

- **High-frequency path:** local ledger updates and task payment in AgentOS
- **Anchor path:** occasional on-chain withdrawals with proof
- **Liquidity path:** mainnet deposits and trust-minimized top-up flow

This allows a practical balance:

- Fast user experience for per-task economics
- Auditability through replayable withdrawal proofs
- Controlled exposure of the settlement-critical chain

## 3. System positioning

### 3.1 Layers

- **TOS Blockchain (base settlement chain):** asset custody, validator-level governance, and final settlement of withdrawals.
- **AgentOS Payment Rail:** high-throughput ledger, session accounting, task fee settlement, and reputation-linked balance updates.
- **AgentOS Validator Layer:** validator set governance, state checkpointing, and proof signing for withdrawals.

### 3.2 What is and is not inside Payment Rail

In scope:

- deposit intent tracking
- off-chain balance bookkeeping
- task usage debit/credit
- settlement proof generation for completed jobs
- withdrawal intent creation
- withdrawal proof signing and replay to TOS chain

Out of scope for now:

- full general-purpose DeFi contracts
- cross-domain token swaps
- generalized smart contract execution engine

## 4. Withdrawal-only anchor model

Only one class of operation writes to TOS Chain in normal flow:

- **Deposit:** user funds are brought to TOS chain balance via an existing wallet/bridge flow.
- **Usage / settlement:** happens in Payment Rail without immediate on-chain writes.
- **Withdraw:** user request triggers `withdraw intent` in Payment Rail, then a relay submits a chain transaction to transfer to mainnet account.

This is a deliberate design choice to maximize throughput while preserving strong withdraw guarantees.

## 5. Core entities

### 5.1 AccountId
A stable logical account identifier in Payment Rail.

### 5.2 RailSession
The unit of execution settlement:

- `session_id`
- `job_id`
- `provider_id`
- `consumer_id`
- `tool_id`
- `requested_amount`
- `settled_amount`
- `status`

### 5.3 RailBalance
Current balance snapshot:

- `account_id`
- `available`
- `locked`
- `nonce`
- `updated_at`

### 5.4 PaymentProof
Proof that a settlement outcome is valid on the rail:

- `session_id`
- `rail_batch_id`
- `account_updates`
- `rail_state_root`
- `validator_sigset`

### 5.5 WithdrawProof
Proof that a user can exit:

- `withdraw_id`
- `account_id`
- `receiver`
- `amount`
- `chain_id`
- `rail_nonce`
- `expires_at`
- `rail_state_root`
- `validator_threshold_signature`

## 6. Throughput design for 10k TPS

To achieve 10k TPS, Payment Rail focuses on operations and consensus constraints that are tractable:

- fixed-width accounting fields and compact tx encoding
- batch execution of debits/credits in worker pools
- lock-free fast-path for wallet reads where no state conflict exists
- asynchronous proof assembly pipeline
- multi-sig verify in parallel with session finalization

The payment path is optimized for frequent small transfers with predictable fields.

## 7. Validator and consensus model (minimal first version)

The first production version can use a stake-aware validator committee with strict role partition:

- proposer role: emits ordered settlement records
- signers set: verifies batch finalization
- witness role: monitors fraud and replay anomalies

Rules:

- withdrawal proof requires threshold signatures from the active signer set
- each batch increments `rail_nonce`
- state replay checks reject duplicated or stale `rail_nonce`

## 8. Flow: job payment life cycle

1. Job execution completes in AgentOS
2. Executor emits session result envelope
3. Settlement engine generates update record for `provider`, `consumer`, and `platform share`
4. Settlement record enters ordered batch
5. RailBalance states update and emit internal event
6. Receipt object carries `session_id` and local settlement hash
7. On user withdrawal request, PaymentProof and WithdrawProof are composed
8. Relay submits withdrawal to TOS Chain and waits for settlement confirmation

## 9. Security requirements

- Nonce-based anti-replay on all withdraw proofs
- proof idempotency for retried withdrawal submissions
- strict separation of local settlement and on-chain exit identity mapping
- slippage guard and minimum exit amount
- dispute window and pause mode for suspicious validator behavior

## 10. API and module integration

Suggested integration points in AgentOS:

- `ledger` service
  - `CreateWithdrawalIntent`
  - `BuildWithdrawProof`
  - `FinalizeRailPayment`
  - `ReplayToTOSChain`
- `market` and `executor`
  - include settlement hash and `session_id` binding in job completion path
- `api`
  - status endpoints for rail balances and pending withdrawals

## 11. Roadmap

### Phase 1 (V2.0 pre-release)
- deposit/withdraw intents
- rail balances and settlement engine
- threshold-signature proof format (single-rail)
- relayer submit path

### Phase 2
- dispute pipeline + fraud detection alerts
- withdrawal simulation mode and replay failure recovery
- index-level observability for rail throughput

### Phase 3
- multi-region validator pools
- regional rail partitions and cross-shard reconciliation
- optional liquidity bridge batching with reduced gas footprint

## 12. Open standards to define in follow-up

- `withdraw_intent` protobuf/JSON schema
- `payment_proof` canonical JSON canonicalization
- validator key rotation and threshold update protocol
- on-chain bridge contract ABI and failure semantics

## 13. Relationship to current docs

This design complements:

- the TOS Network V1 architecture and service skeleton
- V2 implementation of reward and settlement in AgentOS
- current payment proof discussion for receipts and ranking

The Payment Rail is intentionally aligned with `agentos` as a dedicated high-throughput settlement layer under TOS Blockchain. Future documentation should reference this file in roadmap and implementation planning.
