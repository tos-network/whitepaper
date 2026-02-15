# TOS Agent Network v0.1 Scale Design (100k / 100M Agent Interactions)

**Status:** Draft Extension for `whitepaper_v0.1.md` (English)
**Scope:** Architecture design for large-scale deployment and operation
**Target scale:** 100k, 1M, and 100M discoverable Agents with viable interaction throughput

This document defines how to evolve the v0.1 architecture into a horizontally scalable system while keeping protocol compatibility with the v0.1 core loop:

**Discover → Direct Connect → Settle → Receipt → Rank**

---

## 1) Design objectives

1. Preserve v0.1 protocol contracts (AgentRecord, ToolManifest, Receipt, Escrow proof flow)
2. Support massive cardinality without making discovery or ranking O(N)
3. Keep trust guarantees: signature verification, payment proof binding, anti-Sybil economics
4. Keep direct P2P behavior after discovery (no global relay dependency)
5. Enable incremental scaling from v0.1 MVP to 100M-agent-scale operations

---

## 2) What breaks first when we scale

At 100M Agent-level records, naive implementations fail in four ways:

- **Global scans**: query across all categories/shards becomes slow and expensive
- **Monolithic ranking**: single ranking pipeline cannot ingest and update fast enough
- **Chain bottleneck**: every micro-transaction on-chain would become expensive and slow
- **Control-plane coupling**: discovery, settlement validation, and ranking sharing all tied together

So the scale design separates data and responsibility across services, shards, and planes.

---

## 3) Core scaling strategy

## 3.1 Two-plane architecture

- **Control plane**: registration, governance, stake status, challenge policies
- **Data plane**: discovery index, query serving, session bootstrap, receipt ingestion, rank write-back

Reasoning: control-plane objects are small and mostly on-chain/consensus; data-plane objects are large and require distributed storage + parallel compute.

---

## 3.2 Keep v0.1 compatibility and add indirection layers

- `AgentRecord` and `ToolManifest` remain as primary protocol objects
- For scale we add an indirection layer:
  - discovery returns signed pointers/hints (category shards, version pointers)
  - payload bodies can be served from regional/object caches with hash verification

No breaking change for v0.1 consumers; only index providers need to understand hint fields.

---

## 4) Layer-by-layer scale design

## 4.1 Identity & registry layer

### Problems solved
- On-chain bloat if all Agent metadata is stored on chain
- Registry lookups as a single bottleneck

### Design
- On-chain registry keeps only node-level facts:
  - index node identity + stake + category membership + status + operator endpoints
- Agent/provider metadata stays off-chain (content-addressed)
- Registry exposes lightweight roots/checkpoints per epoch

### Practical choices
- Use Merkle/accumulator roots to prove membership or state updates
- Agents are verified by signatures from their TOS key identity (no chain read needed for every lookup)

---

## 4.2 Discovery layer (the largest scaling lever)

### 4.2.1 Category-first + hash-second sharding

Queries must be routed with low fan-out:

- First dimension: `category` (e.g., `Dev.Security`, `Travel.HotelOps`)
- Second dimension: deterministic hash shards (`hash(agent_id) mod S(category)`)

This gives:

- predictable routing target set
- bounded per-query work
- straightforward horizontal scale when shard count grows

### 4.2.2 Multi-region index federation

Introduce regional index routers that aggregate local shards and forward only if needed. Region is selected by policy and latency (not global mandatory hops).

Recommended path:

1. Bootstrap node -> category router
2. Router selects N shards from healthy region shards
3. Parallel read across shards
4. Merge/deduplicate/score client-side and verify signatures
5. Return stable ordered records

### 4.2.3 Index storage and sync model

- Each shard is replicated to `R` replicas (R=3 for baseline, R=5 for critical categories)
- Sync model:
  - incremental gossip/stream from publish source
  - periodic hash checkpoint comparison
  - repair on mismatch detection
- Manifest payloads are content-addressed (`manifest_hash`), so index nodes can exchange only deltas / changed hashes

### 4.2.4 Discovery output contract

`QueryTools` response includes existing v0.1 object plus optional scale hints:

- shard count consulted
- age/last_sync timestamp
- ranking method used
- proof hint ids (for optional deep verification)

---

## 4.3 Connection layer

### 4.3.1 Stateless discovery, stateful transport

Discovery nodes should **not** keep conversation state for calls.

After discovery:
- Agents directly create or reuse P2P sessions
- session establishment uses handshake challenge-response and session key derivation
- session IDs remain globally unique and signed in receipts

### 4.3.2 Libp2p + NAT strategy

At scale, direct transport needs to tolerate NAT and mobile/short-lived nodes:

- Public/relay-assisted transport with fallback
- Peer cache with TTL and heartbeat score
- Provider endpoint list can include multi-transport entries (HTTPS + libp2p multiaddr)

### 4.3.3 Local cache and trust lifetime

- Frequently used `AgentRecord` should be cached locally with TTL and signature re-check on expiry
- Do not keep root signing keys in hot sessions; use session sub-keys

---

## 4.4 Settlement layer

### 4.4.1 Throughput reality

1M~100M interactions requires minimizing on-chain writes.

### 4.4.2 Payment proof abstraction

Extend `PaymentProof` type to support multiple rails while preserving v0.1 fields.

- `tos_escrow_v0`: direct on-chain open/claim/refund
- `tos_channel_v0`: off-chain payment channel with channel close proof
- `tos_batch_v0`: batched settlement proof from checkpoint contract

Receipt keeps accepting v0.1-compatible format; rail-specific proof is an extension to the same field.

### 4.4.3 Receipt binding

Receipt MUST still bind:

- `session_id`
- `tool_id`
- `payment_proof`

The more verifiable the proof, the higher ranking weight.

### 4.4.4 Settlement service model

- Edge nodes can batch and pre-validate claims
- Only dispute or settlement finalization checkpoints are mandatory on main chain
- Asynchronous proof verification is allowed; results include confidence/verification status in ranking feed

---

## 4.5 Feedback & rank layer

### 4.5.1 Two-stage ranking

- **Online ranking tier**: fast candidate ranking for query response (low latency)
- **Batch ranking tier**: periodic full/range recomputation with anti-gaming logic

### 4.5.2 Ranking inputs at scale

Weight inputs by reliability and freshness:

- verifiable payment volume
- success rate
- freshness decay (recent transactions stronger)
- dual-signature receipt ratio
- stake-weight
- challenge outcome history

### 4.5.3 Write-back and decay

- receipts pushed to regional index nodes first
- regional nodes emit ranking deltas
- global ranking epochs reconcile deltas and push back to nodes
- no write-back -> rank decay window applies

---

## 5) Anti-abuse and correctness hardening

1. **Sybil resistance**
   - Stake-gated node participation remains
   - Routing weight depends on stake + observed performance

2. **Index abuse prevention**
   - Proof-of-Index challenge remains lightweight but continuous
   - Randomized challenge assignment and cryptographically verifiable response sets

3. **Query abuse resistance**
   - Rate limits per agent/public key
   - Bloom/guardrails for oversized query payloads

4. **Receipt abuse resistance**
   - Dedup receipt by `receipt_id` and (`session_id`, proof reference)
   - suspicious duplicate/fabricated receipts reduce ranking confidence

5. **Data consistency checks**
   - cross-replica manifest hash reconciliation
   - periodic sampling of manifest content vs hash

---

## 6) Proposed data model extensions (non-breaking)

### 6.1 Discovery routing hint (optional)

A scale-friendly index may optionally return:

- `routing_hints`: list of shard ids already consulted
- `replica_version`: per-shard vector clock/version
- `proof_mode`: `sync`, `async`, or `none`

These are optional and do not break existing v0.1 behavior.

### 6.2 Index node metadata

- `node_id`, `region`, `category_capability`, `shard_capability`, `stake_weight`, `sla_score`

Used for router scheduling and failure-safe failover.

---

## 7) Deployment roadmap from v0.1 to large-scale

### Phase A (v0.1 baseline)
- Core loop implemented
- small set of index nodes and basic category routing

### Phase B (10k~100k Agents)
- category+hash sharding
- multi-replica shard storage
- async payment proof pipeline

### Phase C (1M Agents)
- regional routers
- two-tier ranking
- full Proof-of-Index challenge scheduling

### Phase D (10M~100M Agents)
- libp2p/DHT + gossip discovery for nodes
- batch settlement rail rollout
- federation conflict resolution + periodic global rank epochs

---

## 8) Operational targets (initial)

- P95 discovery latency target (with cache hit): < 300ms
- P95 discovery latency target (cold path): < 2s
- Receipt ingestion target: millions/day at regional node tier; >99.5% integrity checks in batch
- Index inconsistency detection window: < 5 minutes
- Rank freshness: online tier updated in near-real-time, batch tier every epoch

---

## 9) Compatibility statement

This document is an architectural extension and does not replace existing v0.1 semantics.

- v0.1 objects remain accepted
- v0.1 payment proof event types remain valid
- Additional layers improve scale efficiency while preserving verifiability and trust assumptions

---

## 10) Open design questions

1. What is the minimum acceptable index challenge false-negative rate before slash/jail is enforced?
2. Which payment rail should be default at 1M scale (on-chain-first vs channel-first)?
3. How many regional consensus zones are needed before cross-zone routing becomes mandatory?
4. What is the minimum evidence threshold for a receipt to be counted at full rank weight?

