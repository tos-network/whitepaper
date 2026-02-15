# TOS Agent Network Technical Whitepaper v0.1 (Draft)
**Status:** Draft / v0.1  
**Last Updated:** 2026-02-16 (Asia/Tokyo)  
**Audience:** Protocol/node/agent developers, ecosystem partners, auditors, and security teams  
**Scope:** This document defines the minimum viable protocol stack (v0.1) for TOS Agent Network's "Discover → Connect → Settle → Receipt → Rank" lifecycle, along with protocol specifications and interface definitions.

> Note: The goal of v0.1 is to "run the complete loop and make it verifiable," without attempting to cover all advanced features at once (e.g., arbitration, semantic index sharding, network-wide consensus ranking, etc.). This document uses **MUST/SHOULD/MAY** to indicate specification strength.

---

## Table of Contents
1. [Core Philosophy](#1-core-philosophy)  
2. [Context: The Agent Internet Is Forming](#2-context-the-agent-internet-is-forming)  
   - 2.1 From HTTP APIs to MCP Tools  
   - 2.2 Protocol Positioning: Building the Agent Economy Stack  
   - 2.3 Three Missing Pieces of Infrastructure  
3. [Our Answer: A Self-Reinforcing Economic Loop](#3-our-answer-a-self-reinforcing-economic-loop)  
   - 3.1 Lifecycle Overview (DCSRR)  
   - 3.2 The v0.1 "Trusted Minimum Set"  
   - 3.3 Three-Phase Interaction Flow: Discover → Direct Connect → Bypass Entry  
4. [System Architecture: Six-Layer Infrastructure Stack](#4-system-architecture-six-layer-infrastructure-stack)  
   - 4.0 Architecture Overview  
   - 4.1 Identity Layer  
   - 4.2 Registry Layer (On-Chain Registration)  
   - 4.3 Discovery Layer (Decentralized Discovery)  
   - 4.4 Connection Layer (Peer-to-Peer Direct Connection)  
   - 4.5 Settlement Layer (Verifiable Settlement)  
   - 4.6 Feedback & Rank Layer (Reputation & Ranking)  
   - 4.7 Core Innovations  
   - 4.8 Logical Architecture Diagram  
5. [Economic Model: Dual-Track Structure (Key to Growth)](#5-economic-model-dual-track-structure-key-to-growth)  
   - 5.1 Track A: Trust Capital (TOS)  
   - 5.2 Track B: Payment Settlement  
   - 5.3 Network Revenue Model (Three Paths)  
6. [Why This Will Become "Agent Google" (Ranking From Economic Facts)](#6-why-this-will-become-agent-google-ranking-from-economic-facts)  
   - 6.1 From "Content Links" to "Economic Receipts"  
   - 6.2 v0.1 Ranking Principles  
   - 6.3 Ultimate Form: Agent PageRank (Four-Phase Evolution)  
7. [Roadmap (Pragmatic Execution Order)](#7-roadmap-pragmatic-execution-order)  
8. [Conclusion: What We Are Building](#8-conclusion-what-we-are-building)  
Appendices  
- [A. Glossary](#a-glossary)  
- [B. Cryptography & Signature Conventions](#b-cryptography--signature-conventions)  
- [C. Data Structures (v0.1)](#c-data-structures-v01)  
- [D. API & Protocol Messages (v0.1)](#d-api--protocol-messages-v01)  
- [E. TOS Escrow Contract Interface (v0.1)](#e-tos-escrow-contract-interface-v01)  
- [F. Receipt & Payment Proof (v0.1)](#f-receipt--payment-proof-v01)  
- [G. Security & Anti-Abuse Recommendations (v0.1)](#g-security--anti-abuse-recommendations-v01)  

---

# 1. Core Philosophy

TOS Agent Network is NOT:
- An Agent marketplace  
- An MCP directory  
- A search engine  
- A blockchain application  

TOS Agent Network IS:

> 🔥 **The infrastructure layer of the Agent Internet**: providing decentralized discovery, verifiable settlement, and economically receipt-driven reputation and ranking, enabling agents to collaborate, transact, and self-evolve without centralized intermediaries.

**v0.1 Technical Objectives:**
- **Discover**: Verifiable discovery centered on Tool/Capability (not a centralized authoritative directory)  
- **Connect**: Peer-to-peer direct connection after discovery (no entry point relay required)  
- **Settle**: On-chain Escrow as the default settlement proof  
- **Receipt**: Verifiable receipts as unified feedback and ranking signals  
- **Rank**: Update ToolRank/AgentRank with real economic behavior, improving future discovery quality

---

# 2. Context: The Agent Internet Is Forming

## 2.1 From HTTP APIs to MCP Tools
Traditional web services expose HTTP API-centric interfaces; the Agent era is shifting toward **MCP (Model Context Protocol)** centered on **tools/resources/prompts**.  
This means the "callable unit" is transforming from **endpoint** to **tool** (capability).

## 2.2 Protocol Positioning: Building the Agent Economy Stack

### 2.2.1 Two-Layer Architecture
We are building an **Agent Discovery Protocol** that complements the **A2A Interaction Protocol** ([a2a.org](https://a2a.org)) in a two-layer architecture:

**1️⃣ A2A Interaction Protocol (Interaction Layer) — "Conversation Layer"**
- How agents communicate with each other
- How to express tasks / intents
- How to return results
- How to collaborate

**2️⃣ Agent Discovery Protocol (Discovery Layer) — "Discovery Layer"**
- What agents exist in the network?
- Who can perform Solidity audits?
- Who supports Japanese hotel guest service?
- Who is affordable? Who has the best reputation?

### 2.2.2 Analogy

| Layer | Web World Analogy | Blockchain World Analogy |
|-------|-------------------|--------------------------|
| **A2A Interaction Protocol** | HTTP | Transaction Execution |
| **Agent Discovery Protocol** | DNS + Search Engine | Node Discovery + DEX Listing |

### 2.2.3 Key Differences

| Dimension | A2A Interaction Protocol (a2a.org) | TOS Agent Discovery Protocol |
|-----------|-----------------------------------|------------------------------|
| Goal | Define inter-agent communication | Define how agents are discovered |
| Involves indexing | No | Yes |
| Involves ranking | No | Yes |
| Involves staking/economics | No | Yes |
| Involves reputation | No | Yes |

### 2.2.4 Agent Economy Stack

Together they form the complete Agent Economy Stack:

```
┌──────────────────────────┐
│ Agent Discovery          │  ← TOS Agent Network
│ (Discovery, Ranking,     │
│  Reputation)             │
├──────────────────────────┤
│ A2A Interaction          │  ← a2a.org
│ (Conversation,           │
│  Collaboration,          │
│  Tool Invocation)        │
├──────────────────────────┤
│ Settlement & Economics   │  ← TOS Chain
│ (Settlement, Staking,    │
│  Incentives)             │
└──────────────────────────┘
```

> 💡 **Core Positioning**: TOS Agent Network focuses on "Capability Market Infrastructure" (Agent Capability Discovery + Market Layer), not on redefining agent interaction. We solve "who to talk to," while A2A solves "how to talk."

## 2.3 Three Missing Pieces of Infrastructure
The current MCP ecosystem typically lacks:
1. **Decentralized Discovery**: Who provides a given tool? What is its quality?  
2. **Verifiable Settlement**: How to pay/settle with low trust costs?  
3. **Economically-Driven Ranking**: How to prevent sybil attacks and capability spam?

---

# 3. Our Answer: A Self-Reinforcing Economic Loop

The minimum viable loop (v0.1) of this network is:

```
Discover → Direct Connect → Settle → Receipt → Rank Update → Better Discovery
```

## 3.1 Lifecycle Overview (DCSRR)
- **Discover**: Consumer (Consumer Agent / user) obtains candidate Tools/Agents (with signed records) from the discovery network  
- **Direct Connect**: Consumer and Provider Agent negotiate tools, pricing, and settlement rails via the **A2A Protocol** handshake, generating a `session_id`  
- **Settle**: Consumer locks funds in an on-chain Escrow, producing payment proof  
- **Receipt**: After invocation completes, a Receipt is generated, binding `session_id` with PaymentProof  
- **Rank Update**: Index Nodes collect receipts and update ToolRank/AgentRank, feeding back into Discover ranking

## 3.2 The v0.1 "Trusted Minimum Set"
v0.1 must satisfy:
- Discovery results are signature-verifiable (no trust in any single entry point/node)  
- Settlement events are on-chain verifiable (proof)  
- Receipts and settlement proofs can be bound to the same `session_id` (preventing replay and fake feedback)

## 3.3 Three-Phase Interaction Flow: Discover → Direct Connect → Bypass Entry

> 💡 **Core Principle**: tos.network is only responsible for "discovery," not traffic relay. Once Agent A finds Agent B through search, they can establish a direct connection and bypass the entry point.

### 🟢 Phase 1: Discovery (via tos.network)
Agent A queries: "Who can perform Solidity audits?" "Who supports Japanese hotel guest service?"

**Entry point responsibilities:**
- Route queries to relevant category nodes
- Aggregate results returned by multiple nodes
- Rank results (based on ToolRank/AgentRank)
- Return `AgentRecord` (containing endpoint + public key + manifest hash + stake/reputation info)

### 🟡 Phase 2: Handshake (Peer-to-Peer Trust Establishment)
Agent A obtains Agent B's public key, endpoint, and capability schema, then:

**Handshake flow:**
1. Verify Agent B's signature and stake information
2. Initiate handshake (challenge-response)
3. Establish session (libp2p / HTTPS / A2A Protocol)

**Key point:** tos.network is no longer involved from this point forward

### 🔵 Phase 3: Direct A2A Interaction (The Real Agent Economy)
All subsequent interaction is fully peer-to-peer:

- Direct HTTP / libp2p communication
- A2A Protocol message exchange
- Settlement via TOS Chain (Escrow)
- Long-lived connections possible (subscriptions/callbacks)

**Optimization:** If Agent A frequently calls Agent B, it can locally cache B's record and establish a persistent connection without querying the network.

> 🌐 **Ecosystem Vision**: This creates a decentralized **Agent Call Graph**, laying the foundation for future **Agent PageRank**.

---

# 4. System Architecture: Six-Layer Infrastructure Stack

> 💡 **Core Positioning**: TOS Agent Network is not a search engine, not an A2A protocol, not a marketplace — it is the **infrastructure layer of the Agent economy**.

## 4.0 Architecture Overview

TOS Agent Network provides complete Agent economic infrastructure through a six-layer architecture:

```
┌──────────────────────────────────────────┐
│  Layer 6: Feedback & Rank Layer          │  Reputation & Ranking
│  (Receipt, AgentRank, Agent PageRank)    │
├──────────────────────────────────────────┤
│  Layer 5: Settlement Layer               │  Verifiable Settlement
│  (TOS Escrow, Dispute)                   │
├──────────────────────────────────────────┤
│  Layer 4: Connection Layer               │  Peer-to-Peer Direct
│  (Handshake, Session, A2A Protocol)      │
├──────────────────────────────────────────┤
│  Layer 3: Discovery Layer                │  Decentralized Discovery
│  (tos.network, Index Nodes, DHT/Gossip)  │
├──────────────────────────────────────────┤
│  Layer 2: Registry Layer                 │  On-Chain Registration
│  (Stake, Category, Slashing)             │
├──────────────────────────────────────────┤
│  Layer 1: Identity Layer                 │  Identity Foundation
│  (TOS Address, Signature, Verification)  │
└──────────────────────────────────────────┘
```

**Complete Feedback Loop:**
```
Discover → Connect → Settle → Receipt → Rank Update → Influences Future Discovery
```

This is a **self-reinforcing system**: real economic behavior drives reputation, reputation influences discovery ranking, forming a positive feedback loop.

---

## 4.1 Identity Layer

**Core Principle**: Agent = TOS Public Key Identity

### 4.1.1 Agent Identity
- Every Agent (including nodes) has a key pair: `(pubkey, privkey)`  
- `agent_id` **MUST** be derivable from `pubkey` to a TOS address: `agent_id = tos_address(pubkey)`
- All actions are signed by this identity:
  - Publishing Manifests
  - Registering nodes
  - Submitting Receipts
  - Settling transactions

### 4.1.2 Signatures & Verification
All objects that can be "propagated/indexed/settlement-bound" **MUST** be signature-verifiable:  
- `AgentRecord` (returned by discovery)  
- `ToolManifest` (capability declaration)  
- `Receipt` (execution receipt)  
- Handshake Transcript (optional)

### 4.1.3 Session Sub-Keys (Recommended)
- Provider **SHOULD** use `session_pubkey` for short-term communication
- Issued by the root key, reducing root key exposure

> 💡 **This is the root of the entire system**: all stake, receipts, and rankings are bound to identity.

---

## 4.2 Registry Layer (On-Chain Registration)

**Core Function**: Maintaining node registration, staking, categories, and status on the TOS chain

### 4.2.1 On-Chain Registry Contract
Index Nodes must register and stake TOS through an on-chain Registry contract (or native module) to join the network. The Registry **MUST** maintain the following state:

**Node record fields:**
- `node_id`: Node public key/address
- `endpoints`: Node service endpoints (optional: store only hash, full content via AENR)
- `categories[]`: List of categories the node is responsible for
- `stake_amount`: Current total stake
- `status`: Node status (`active` / `jailed` / `exit_pending`)
- `last_heartbeat`: Last heartbeat time (optional)
- `reputation_score`: Reputation score (based on SLA, challenge results, user feedback)

### 4.2.2 Node Admission & Staking Requirements
**Minimum staking requirements:**
- `minStakePerNode`: Minimum stake required to operate a node
- `minStakePerCategory`: Additional stake required per category joined (prevents category spamming)
- `lockPeriod`: Exit unlock period (prevents immediate withdrawal after misbehavior)

**Registration flow:**
1. Node calls `registerNode(endpoints, initialStake)`
2. Contract verifies `initialStake >= minStakePerNode`
3. Node status set to `active`, ready to receive queries

### 4.2.3 Category Participation (Category-based Routing)
The network is sharded by "Category," with each category served by a set of responsible nodes:

**Category design:**
- Categories use a hierarchical structure, e.g.: `Dev.Security`, `Travel.HotelOps`
- Nodes call `joinCategory(category_key)` to join a category
- Nodes **MUST** maintain the complete index for their joined categories (manifests, inverted index, etc.)
- Entry router: queries for a specific category are routed only to the node set for that category

**Category discovery:**
- `category_key = hash("category:Dev.Security")`
- Use DHT or on-chain Registry for fast lookup of the responsible node set

### 4.2.4 Node Revenue Model
Nodes earn revenue through two mechanisms (v0.1 must support at least one):

**A) Search Fee**
- A small amount of TOS paid per query (can be paid by the entry point or directly by the user)
- Entry point distributes fees to result-returning nodes weighted by contribution/quality

**B) Listing Fee / Renewal**
- Agents pay a fee or additional stake to publish a manifest
- This fee is distributed to category nodes that index and serve queries for the manifest

> 💡 **Positive feedback loop**: Popular categories → more revenue → more nodes join → stronger availability and redundancy

### 4.2.5 Slashing / Jail (Penalty Mechanism)
**Punishable behaviors:**
- Indexing spam content or returning clearly irrelevant results (reported by majority of nodes/users)
- Returning forged records (signature verification failure, manifest hash doesn't exist)
- Extended unavailability (SLA failure, heartbeat timeout)
- Index challenge failure (see 4.3.6 Index Proof Challenge)

**Penalty types:**
- **Demotion**: Reduced routing weight, less traffic and revenue (most common)
- **Slashing**: Partial stake forfeiture (for severe or repeated offenses)
- **Jail**: Temporary removal from category or entire network; must re-stake to recover

**v0.1 implementation recommendation:**
- Define penalty interfaces and events
- Initially use only the demotion mechanism
- v0.2+ enables full slashing and arbitration workflows

> 💡 **Purpose**: Sybil resistance, verifiable stake, settlement assurance

---

## 4.3 Discovery Layer (Decentralized Discovery)

**Core Function**: Decentralized Agent capability discovery and indexing

### 4.3.1 Index Object: MCP Tool
- The core object of network discovery is the **MCP Tool Capability**, not an HTTP endpoint
- Each Tool is uniquely identified by `tool_id` (recommended: `<agent_id>#<tool_name>@<version>` or hash-derived)

### 4.3.2 ToolManifest
- Provider **MUST** publish a signed `ToolManifest` (see Appendix C)  
- Manifest **MUST** include:
  - `tools[]`: tool name, description, input/output schema (JSON Schema or equivalent), pricing, SLA/constraints  
  - `settlement`: settlement configuration (v0.1 uses TOS Escrow)  
  - `expires_at`: expiration time (requiring renewal/re-publication)

### 4.3.3 Index Node Responsibilities (v0.1)
Index Nodes **MUST** provide:
- Publish capability (publish manifest / record)  
- Query retrieval (keyword + facet filtering)  
- Resolution (resolve manifest hash/record)  
- Receipt ingestion and statistical output (rank snapshot)
- Category index maintenance (for joined categories)

### 4.3.4 tos.network Entry Point Responsibilities
tos.network serves as the **default aggregation entry point**, providing a Web2 UX, but the underlying data and indexes are fully decentralized. The entry point does not store data; it performs only three functions:

**1) Bootstrap**
- Provides a default "entry node list" (a set of high-quality node ENRs/AENRs)
- Clients can quickly connect to the network via the entry point

**2) Query Router**
- Routes queries to a batch of nodes based on query category, geography, load, and node reputation
- Supports category routing: `Dev.Security` queries are directed only to the node set for that category
- Supports load balancing and failover

**3) Result Aggregator**
- Aggregates results returned by multiple nodes
- Deduplicates, verifies signatures, and ranks (based on ToolRank/AgentRank)
- Presents results to the user

> 💡 **Key characteristic**: The entry point has centralized UX, but data and indexes are decentralized. Multiple mirror sites are possible, and the protocol allows anyone to run an entry point.

### 4.3.5 Category-based Routing
Queries are routed to the corresponding node set by category:

**Routing flow:**
1. User query specifies a category (e.g., `category: "Dev.Security"`)
2. Entry point retrieves the node list for that category from the Registry
3. Selects N nodes (based on stake, reputation, latency)
4. Sends query requests in parallel
5. Aggregates and returns results

### 4.3.6 Index Proof Challenge
To prevent nodes from claiming to have indexes but actually returning garbage, a lightweight challenge mechanism is introduced:

**Challenge flow:**
1. Entry point or any node randomly audits: gives a node a query + expected recall set (or verifiable sample)
2. Node must respond within a time limit with:
   - Verifiable `AgentRecord` (with signature)
   - Resolvable manifest CID/hash
3. Failures count toward SLA/reputation; cumulative failures trigger jail/slash

**Challenge types (v0.1 recommended):**
- **Existence challenge**: Prove the node actually indexes a known manifest
- **Recall challenge**: Given a keyword, verify the node can recall expected results

> 💡 **Analogy**: This is similar to "proof of work," but lighter — **Proof of Index**

### 4.3.7 Node Interconnection & Synchronization
**v0.1 implementation (simplified):**
- Uses static node lists + HTTP push/pull synchronization
- Nodes periodically fetch other node lists from the Registry
- New manifests synchronized via webhook or polling

**v0.2+ extension:**
- Introduce DHT/Gossip (e.g., libp2p) for automatic node discovery
- Use gossipsub to broadcast new manifests and receipts
- Support dynamic node join/leave

---

## 4.4 Connection Layer (Peer-to-Peer Direct Connection)

**Core Function**: Establishing trusted peer-to-peer connections between Agents

### 4.4.1 Direct Connection Flow
1. **Discovery**: Consumer obtains `AgentRecord` via the Discovery Layer
2. **Verification**: Verify signature + resolve manifest + verify stake info
3. **Handshake**: Both parties handshake via A2A Protocol (challenge-response)
4. **Session Establishment**: Generate `session_id`, establish communication channel (libp2p / HTTPS)

### 4.4.2 Key Characteristics
**No longer dependent on tos.network after connection:**
- Fully peer-to-peer communication
- Long-lived connections possible (subscriptions/callbacks)
- Locally cache frequently-used Agent records

### 4.4.3 A2A Protocol Integration
- After handshake, Agents use the **A2A Protocol** (a2a.org) for actual interaction
- A2A handles: task expression, result delivery, tool invocation, collaboration workflows
- TOS Agent Network handles: discovery, reputation, settlement

---

## 4.5 Settlement Layer (Verifiable Settlement)

**Core Function**: Providing verifiable on-chain settlement guarantees

### 4.5.1 TOS Chain Escrow
- v0.1 **MUST** support TOS on-chain Escrow contract settlement  
- Contract interface uses EVM-compatible ABI (Solidity)

### 4.5.2 Escrow State Machine
- `None` → `Open` → (`Claimed` | `Refunded`)

### 4.5.3 External Methods (Minimum Set)
- `open(sessionId, payee, amount, expiry, termsHash)`  
- `claim(sessionId, receiptHash)`  
- `refund(sessionId)`

> v0.1 may support only native currency (`msg.value == amount`); v0.2+ extends to ERC20.

### 4.5.4 Events (Payment Proof)
- `EscrowOpened(sessionId, payer, payee, asset, amount, expiry, termsHash)`  
- `EscrowClaimed(sessionId, payee, receiptHash)`  
- `EscrowRefunded(sessionId, payer)`

### 4.5.5 Settlement Proof (Payment Proof)
- On-chain events (logs) serve as proof: `chain_id + tx_hash + log_index`  
- Proof **MUST** be verifiable by any node via RPC/light client (v0.1 allows RPC verification)

**PaymentProof (v0.1) recommended reference format:**
```json
{
  "rail": "tos_escrow_v0",
  "chain_id": "tos-mainnet",
  "tx_hash": "0x...",
  "log_index": 12,
  "event": "EscrowClaimed"
}
```

> 💡 **Purpose**: Ensures no rug-pulls, refundable, disputable (future extension)

---

## 4.6 Feedback & Rank Layer (Reputation & Ranking)

**Core Function**: Reputation system based on real economic behavior

### 4.6.1 Receipt
- Every tool invocation **SHOULD** produce a `Receipt` (see Appendix F)
- Receipt **MUST** bind:
  - `session_id`
  - `tool_id`
  - `payment_proof` (at minimum referencing the Escrow event proof)
- Receipt **SHOULD** be dual-signed (provider + consumer); v0.1 allows single-signing but with reduced weight

### 4.6.2 Rank (v0.1 Minimum Viable)
Index Nodes **SHOULD** maintain two types of scores:
- `ToolRank` (tool-level)
- `AgentRank` (agent-level)

**v0.1 recommended ranking signals:**
- Transaction volume/count (based on verifiable proofs)
- Success rate (receipt status)
- Dispute/refund rate (if dispute is introduced)
- Stake weight (from on-chain)

### 4.6.3 Reputation Writeback Mechanism
**Key design:**
- Reputation updates must be written back to the network: Receipts submitted to Index Nodes to update Rank
- No writeback → ranking decay: Agents that stop submitting receipts see reputation decline
- Natural ecosystem return: Even with direct connections, agents must interact with the network to maintain high rankings

> 🔥 **This creates a positive feedback loop**: High reputation → more discovery → more transactions → higher reputation

---

## 4.7 Core Innovations

The core innovation of TOS Agent Network is not any single technology, but the **complete infrastructure combination**:

| Dimension | Tor/BT | Google | TOS Agent Network |
|-----------|--------|--------|-------------------|
| Decentralized Discovery | ✅ | ❌ | ✅ |
| Peer-to-Peer Direct Connection | ✅ | ❌ | ✅ |
| Verifiable Settlement | ❌ | ❌ | ✅ |
| Economically-Driven Ranking | ❌ | ✅ | ✅ |

> 🌐 **Positioning**: A decentralized Google + Tor + BT + Stripe

---

## 4.8 Logical Architecture Diagram

```
                ┌──────────────────┐
                │   tos.network    │
                │ (Entry + Aggreg) │
                └─────────┬────────┘
                          │
                ┌─────────▼─────────┐
                │  Discovery Nodes  │
                │(Category Sharding │
                │    + DHT)         │
                └─────────┬─────────┘
                          │
         ┌────────────────┼────────────────┐
         ▼                ▼                ▼
     Agent A          Agent B          Agent C
         │                │
         └── Direct Handshake ──┘
                     │
                  Escrow
                     │
                  Receipt
                     │
              Rank Update
```

---

# 5. Economic Model: Dual-Track Structure (Key to Growth)

## 5.1 Track A: Trust Capital (TOS)
- Node staking and governance backed by TOS  
- Purpose: Sybil resistance, punishability, routing weight

## 5.2 Track B: Payment Settlement
- v0.1 uses TOS Escrow (on-chain proof) for payment settlement  
- All payments completed through TOS on-chain Escrow contracts, providing verifiable on-chain proof

## 5.3 Network Revenue Model (Three Paths)

> 💡 **Key question**: If Agents bypass tos.network after establishing direct connections, how does the network continue to earn revenue?

**1️⃣ Discovery-Phase Fees (Google Model)**
- **Search Fee**: Small TOS payment per query
- **Listing Fee**: Agents pay a fee or stake to publish a manifest
- **Promotion Fee**: Agents can pay extra to boost rankings (must be clearly labeled)

**2️⃣ Optional Intermediated Settlement**
- Both agents can opt to settle through TOS Escrow contracts
- Network charges a settlement fee (e.g., 1-2%)
- Dispute arbitration service (optional)

**3️⃣ Reputation Layer (Strongest Model)** ⭐
- **Reputation updates must be written back to the network**: Receipts submitted to Index Nodes to update Rank
- **No writeback → ranking decay**: Agents that stop submitting receipts see reputation decline
- **Natural ecosystem return**: Even with direct connections, agents must interact with the network to maintain high rankings

> 🔥 **Strategic advantage**: The third model is the strongest because it is not coercive, yet the ecosystem naturally returns. This creates a **positive feedback loop**: High reputation → more discovery → more transactions → higher reputation.

---

# 6. Why This Will Become "Agent Google" (Ranking From Economic Facts)

Google's key innovation is not "indexing" but "ranking."  
TOS Agent Network's key is not "cataloging" but "**economically verifiable ToolRank/AgentRank**."

## 6.1 From "Content Links" to "Economic Receipts"
- The Web's PageRank comes from link structure  
- Agent network Rank comes from:
  - Verifiable settlement facts (proof)
  - Verifiable delivery receipts
  - Capitalized trust (stake)
  - Future: Agent Call Graph / Agent PageRank

## 6.2 v0.1 Ranking Principles (Recommended)
- **proof-backed volume > self-claim**: Real transactions take priority over self-declarations  
- **Dual-signed receipts > single-signed receipts**: Dual-signing carries more weight  
- **Stake as sybil resistance weight**: Higher stake = higher cost to game rankings  
- **Freshness**: Recent performance matters more

## 6.3 Ultimate Form: Agent PageRank (Four-Phase Evolution)

> 🎯 **Vision**: Evolve from simple economic ranking to **Agent PageRank** based on Agent Call Graphs, ultimately forming the true "Agent Google."

**Phase One: Discovery via tos.network**
- Agents discover other agents through search
- Ranked by stake, transaction volume, success rate

**Phase Two: Forming Agent-to-Agent Direct Connections**
- Agents establish peer-to-peer connections
- Locally cache frequently-used agent records
- Reduced dependency on the entry point

**Phase Three: Forming the Agent Call Graph**
- Recording inter-agent invocation relationships
- Which agents are frequently called by other high-reputation agents
- Forming a decentralized Agent social graph

**Phase Four: Agent PageRank**
- Search results begin to factor in "inter-agent invocation relationships"
- Similar to the Web's PageRank: agents called more frequently by higher-quality agents rank higher
- Combining economic facts (transaction volume) + social graph (invocation relationships) + capital proof (stake)

> 🔥 **This is the true "Agent Google"**: not just indexing capabilities, but understanding the trust network of the Agent ecosystem.

---

# 7. Roadmap (Pragmatic Execution Order)

## Phase 0 (v0.1) — Close the Loop
- Identity Layer: Agent key pairs and signature infrastructure  
- Registry contract: Node registration, minimum stake admission  
- Single/few Index Nodes + tos.network entry point  
- MCP Tool publishing and retrieval (keyword + facet + category routing)  
- TOS Escrow: `open/claim/refund`  
- Connection Layer: A2A Protocol handshake and direct connection  
- Receipt: Format and signature verification, on-chain proof binding  
- ToolRank/AgentRank: Minimum implementation  
- Reputation writeback mechanism (Receipt → Index Node → Rank Update)

## Phase 1 (v0.2) — Multi-Node & Index Assurance
- Multi-node redundancy and entry point fan-out aggregation  
- Basic node synchronization (HTTP push/pull)  
- Category sharding (Category-based Routing refinement)  
- Index challenge mechanism (Proof of Index)  
- Node revenue sharing (search fees + listing fees)

## Phase 2 (v0.3) — Decentralized Network
- libp2p + DHT/Gossip node discovery  
- Full slashing/jail penalty workflow  
- Decentralized entry points (multi-mirror support)  
- Semantic search nodes (optional)

## Phase 3 (v0.4+) — Agent PageRank
- Agent Call Graph (invocation relationship recording)  
- Agent PageRank (based on call graph + economic flow + stake)  
- Dispute arbitration mechanism

---

# 8. Conclusion: What We Are Building

TOS Agent Network is:
- A decentralized Tool/Agent discovery layer  
- A verifiable settlement layer (with on-chain events as proof)  
- A receipt-based reputation and ranking layer  

It is not an application, but **infrastructure for the Agent Internet**:  
enabling devices of any scale — from Raspberry Pis to data centers — to join, be discovered, be invoked, be settled, and be evaluated in an MCP-native manner.

---

# A. Glossary

- **Agent**: An entity that can externally provide or consume tools (software instance/service)  
- **Provider**: An agent that provides tools  
- **Consumer**: An agent or user that invokes tools  
- **Index Node**: A node that maintains indexes, handles queries, and aggregates receipts (requires stake)  
- **tos.network**: The default entry point and aggregation endpoint (non-authoritative), providing three functions: Bootstrap, Query Router, and Result Aggregator  
- **Tool**: An MCP tool capability unit  
- **ToolManifest**: A signed declaration of tool catalog with schema, pricing, and constraints  
- **AgentRecord**: A lightweight signed record for discovery and connection (containing endpoint and manifest pointers)  
- **session_id**: A unique session identifier derived from the direct connection handshake  
- **terms_hash**: Transaction terms hash (binding tool version, quote, SLA, deadline, etc.)  
- **Receipt**: Execution receipt (binding execution with payment proof, used for ranking)  
- **PaymentProof**: Payment proof (v0.1 is an on-chain event reference)  
- **Registry**: On-chain registration contract maintaining node registration, staking, categories, and status  
- **Category**: A basic unit of network category-based sharding (e.g., `Dev.Security`, `Travel.HotelOps`)  
- **A2A Protocol**: Agent-to-Agent interaction protocol ([a2a.org](https://a2a.org)), defining inter-agent communication  
- **Agent PageRank**: A ranking algorithm based on Agent Call Graphs (future phase)  
- **Index Proof Challenge**: A verification mechanism to prevent nodes from claiming to have indexes while returning garbage  
- **Connection Layer**: Peer-to-peer direct connection layer; agents establish trusted connections and bypass the entry point  
- **Escrow**: On-chain custody contract providing verifiable payment guarantees (open → claim/refund)  

---

# B. Cryptography & Signature Conventions

## B.1 Hashing
- `hash()` defaults to `keccak256` (EVM-compatible)  
- If the TOS chain uses a different standard, the v0.1 implementation may specify via the `hash_alg` field

## B.2 Signature Algorithm
- `sig_alg` **MUST** be explicitly declared in all objects  
- Recommended support:
  - `secp256k1` (commonly used in EVM)  
  - `ed25519` (high-performance general purpose)  
- The mapping from `agent_id` to `pubkey` **MUST** be consistent with the TOS address specification

## B.3 Canonical Serialization
- Objects used for signing must be canonically serialized (otherwise multi-implementation interoperability fails)  
- v0.1 recommendation:
  - JSON Canonicalization Scheme (JCS) or  
  - CBOR Canonical Encoding  
- `sig` computation: `sig = Sign(privkey, hash(canonical_bytes(payload)))`

---

# C. Data Structures (v0.1)

> The following are reference JSON structures. Implementations may use protobuf/CBOR, but semantic fields must be equivalent.

## C.1 AgentRecord ("Lightweight Record" Returned by Discovery)
```json
{
  "record_version": "0.1",
  "agent_id": "tos1...",
  "pubkey": "base64...",
  "endpoints": [
    {"type": "https", "url": "https://agent.example.com/mcp"},
    {"type": "libp2p", "multiaddr": "/ip4/.../tcp/.../p2p/..."}
  ],
  "manifest_hash": "0x...",
  "capability_digest": "0x...",
  "pricing_digest": "0x...",
  "stake_ref": {
    "chain_id": "tos-mainnet",
    "registry": "0xRegistryContract",
    "key": "0x..."
  },
  "expires_at": 1760600000,
  "sig_alg": "secp256k1",
  "sig": "0x..."
}
```

## C.2 ToolManifest (MCP Tool Manifest)
```json
{
  "manifest_version": "0.1",
  "agent_id": "tos1...",
  "updated_at": 1760000000,
  "expires_at": 1760600000,
  "tools": [
    {
      "tool_id": "tos1...#hotel_guest_reply@1",
      "name": "hotel_guest_reply",
      "description": "Draft multilingual replies for hotel guests",
      "input_schema": {"type":"object","properties":{"message":{"type":"string"}},"required":["message"]},
      "output_schema": {"type":"object","properties":{"reply":{"type":"string"}},"required":["reply"]},
      "constraints": {"languages":["en","ja","zh"],"rate_limit_rpm":60,"max_input_bytes":20000},
      "pricing": {"model":"per_call","amount":"0.02","asset":"TOS"},
      "settlement": {"rail":"tos_escrow_v0","chain_id":"tos-mainnet"}
    }
  ],
  "sig_alg": "secp256k1",
  "sig": "0x..."
}
```

---

# D. API & Protocol Messages (v0.1)

> v0.1 recommends Index Nodes provide an HTTP JSON API; this can also be mapped to MCP tools (recommended approach).

## D.1 PublishManifest
- **POST** `/v0.1/manifests`
- Input: `ToolManifest`
- Behavior:
  - Validate signature and expiration time
  - Generate/update index entries
- Output: `{ "ok": true, "manifest_hash": "0x..." }`

## D.2 QueryTools
- **POST** `/v0.1/query`
- Input:
```json
{
  "category": "Travel.HotelOps",
  "q": "japanese guest reply",
  "facets": {
    "language": "ja",
    "settlement_rail": "tos_escrow_v0",
    "price_max": "0.05"
  },
  "limit": 50
}
```
- Output: `AgentRecord[]` (or summary + record_hash)

## D.3 Resolve
- **GET** `/v0.1/resolve/{manifest_hash}`
- Output: `ToolManifest`

## D.4 SubmitReceipt
- **POST** `/v0.1/receipts`
- Input: `Receipt`
- Behavior:
  - Verify signature
  - Validate payment proof (v0.1 allows asynchronous validation)
  - Deduplicate (by `receipt_id` or `session_id+payment_ref`)
- Output: `{ "ok": true }`

---

# E. TOS Escrow Contract Interface (v0.1)

> Contract uses EVM-compatible ABI (Solidity).

## E.1 State Machine
- `None` → `Open` → (`Claimed` | `Refunded`)

## E.2 External Methods (Minimum Set)
- `open(sessionId, payee, amount, expiry, termsHash)`  
- `claim(sessionId, receiptHash)`  
- `refund(sessionId)`

> v0.1 may support only native currency (`msg.value == amount`); v0.2+ extends to ERC20.

## E.3 Events (Payment Proof)
- `EscrowOpened(sessionId, payer, payee, asset, amount, expiry, termsHash)`  
- `EscrowClaimed(sessionId, payee, receiptHash)`  
- `EscrowRefunded(sessionId, payer)`

**PaymentProof (v0.1) recommended reference format:**
```json
{
  "rail": "tos_escrow_v0",
  "chain_id": "tos-mainnet",
  "tx_hash": "0x...",
  "log_index": 12,
  "event": "EscrowClaimed"
}
```

---

# F. Receipt & Payment Proof (v0.1)

## F.1 Receipt Structure
```json
{
  "receipt_version": "0.1",
  "receipt_id": "0x...", 
  "session_id": "0x...",
  "tool_id": "tos1...#hotel_guest_reply@1",
  "task_hash": "0x...",
  "result_hash": "0x...",
  "status": "success",
  "cost": {"amount":"0.02","asset":"TOS"},
  "payment_proof": {
    "rail": "tos_escrow_v0",
    "chain_id": "tos-mainnet",
    "tx_hash": "0x...",
    "log_index": 12,
    "event": "EscrowClaimed"
  },
  "timestamp": 1760000100,
  "sig_provider": {"sig_alg":"secp256k1","sig":"0x..."},
  "sig_consumer": {"sig_alg":"secp256k1","sig":"0x..."}
}
```

## F.2 receipt_id Computation Recommendation
- `receipt_id = hash(session_id || tool_id || payment_proof.tx_hash || payment_proof.log_index)`

## F.3 Proof Verification Rules (v0.1)
When an Index Node receives a receipt:
- **MUST** verify signature (at least provider's)  
- **SHOULD** verify via RPC that the `EscrowClaimed` event exists and that `sessionId` matches  
- **MAY** allow ingest-first-verify-later (but unverified receipts should carry lower ranking weight)

---

# G. Security & Anti-Abuse Recommendations (v0.1)

## G.1 Anti-Spam (Publishing & Querying)
- PublishManifest **SHOULD** require a minimum fee or stake (determined by node policy)  
- Rate-limit publishing frequency per `agent_id`  
- All input lengths **MUST** have upper bounds (preventing memory/CPU attacks)

## G.2 Sybil Resistance
- Index Node admission **MUST** be tied to on-chain stake  
- Routing and aggregation **SHOULD** weight by stake and historical performance

## G.3 Evidence & Privacy
- Task/result content does not need to go on-chain; use `task_hash/result_hash`  
- For sensitive data, clients can encrypt task content and share only digests for verifiability

## G.4 Supply Chain Security
- Reproducible builds, signed images, and version pinning are recommended  
- Critical parsers and network entry points should undergo fuzz testing (especially C/C++ implementations)

---

**End of Document**
