# TOS Whitepaper

This repository contains two core whitepapers for the TOS ecosystem.

## TOS Ecosystem One-Liner

**TOS Blockchain** is a secure, fast, privacy-focused infrastructure layer for deterministic execution and programmable automation.  
**TOS Network** is the decentralized Agent-to-Agent execution layer on top of it, enabling discovery, task matching, and privacy-preserving collaboration across nodes (including home-edge nodes without public IP), with settlement and reward semantics anchored to TOS Blockchain.

---

## 📁 Repository Structure

```
whitepaper/
├── blockchain/   ← TOS Blockchain Whitepaper
└── network/      ← TOS Agent Network Whitepaper
```

---

## ⛓️ blockchain/ — TOS Blockchain

The **TOS Blockchain** defines the on-chain foundation layer for the Agent economy.

TOS Blockchain is a high-performance infrastructure layer designed for deterministic execution, advanced privacy, and programmable automation.  
It can support DeFi, dApps, and future AI-driven applications — but those are use cases built on top of the protocol, not the identity of the protocol itself.  
The core identity is: secure, fast, privacy-focused infrastructure for builders.

The core thesis is to advance blockchains from "general computation" to a **General Economic Agency Layer**: agents have on-chain identity, can take jobs, get verifiably paid, settle in compute/energy units, and self-govern on auditable policy rails.

**Key Innovations:**
- **Agent-First Identity Stack** — Native DID, key rotation, and attribute attestations make autonomous agents first-class on-chain citizens
- **AGIW (Proof-of-Intelligent-Work)** — Turns "intelligent work" into a verifiable Receipt Protocol, decoupled from consensus
- **Native Compute/Energy Units (CC/EC)** — Compute Credits and Energy Credits at the ledger level, not just ERC-20 tokens
- **TOS Energy Model (TEM)** — Anchors monetary/treasury policy to GPU-minute and kWh scarcity indices
- **Agent Task Market** — A protocol-native minimal viable market: task → receipt → dispute → settlement → reputation
- **Safety Oracle + Policy Wallets** — Compliance at validation time, preserving decentralization

> **TOS is not "a faster EVM." It is the first chain that turns agent work, reputation, and energy use into a measurable, settleable, and governable economic substrate.**

📄 Source: [`blockchain/tos.tex`](blockchain/tos.tex) (LaTeX)  
📄 PDF: [`blockchain/tos.pdf`](blockchain/tos.pdf) (available in 17 languages)

---

## 🌐 network/ — TOS Agent Network

The **TOS Agent Network** defines the off-chain discovery and collaboration layer for the Agent economy.

TOS Network is the decentralized Agent-to-Agent execution layer in the TOS ecosystem, enabling independent nodes (including home-edge nodes without public IP) to publish capabilities, discover peers, match tasks, and execute jobs via direct/relay networking with privacy-preserving operational workflows.  
It is built as an identity-and-execution separation design: the base chain provides the secure infrastructure, while the network layer provides practical interoperability and large-scale AI service collaboration. Rewarding, settlement, and proof-related logic are ultimately based on TOS Blockchain.

The core thesis is to build a **decentralized Agent discovery infrastructure** — not a search engine, not an A2A protocol, not a marketplace, but the "DNS + Google + Reputation Layer" for the Agent Internet.

**Six-Layer Architecture:**
1. **Identity Layer** — Agent = TOS public key identity
2. **Registry Layer** — On-chain registration, staking, categories, slashing
3. **Discovery Layer** — Decentralized index network + tos.network entry point
4. **Connection Layer** — Peer-to-peer direct connection, bypassing the entry point after discovery
5. **Settlement Layer** — TOS Escrow on-chain settlement guarantee
6. **Feedback & Rank Layer** — Economically verifiable AgentRank / Agent PageRank

**Core Feedback Loop:**
```
Discover → Connect → Settle → Receipt → Rank Update → Influences Future Discovery
```

> **TOS Agent Network is not an application layer — it is a protocol layer: economically verifiable Agent discovery infrastructure.**

📄 Whitepaper: [`network/tosagent_Whitepaper_v0.1.md`](network/tosagent_Whitepaper_v0.1.md)

---

## 🔗 How They Relate

```
┌─────────────────────────────────┐
│  TOS Agent Network (network/)   │  Discovery, Ranking, Reputation
│  Agent Discovery Protocol       │
├─────────────────────────────────┤
│  A2A Interaction (a2a.org)      │  Conversation, Collaboration, Tool Calls
├─────────────────────────────────┤
│  TOS Blockchain (blockchain/)   │  Identity, Settlement, Staking, Governance
│  Economic Agency Layer          │
└─────────────────────────────────┘
```

- **TOS Blockchain** provides the on-chain primitives: identity, settlement (Escrow), staking, governance
- **TOS Agent Network** builds an off-chain discovery network on top of those primitives: indexing, ranking, reputation

Together they form the complete **Agent Economy Stack**.
