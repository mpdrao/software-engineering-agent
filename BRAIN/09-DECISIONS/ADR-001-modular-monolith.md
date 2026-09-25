---
type: decision
status: standard
domain: architecture
id: ADR-001
title: "ADR-001: Adoção de Monolito Modular em vez de Microservices Prematuros"
tags: [adr, architecture, decision, modular-monolith, standard]
created: 2026-09-25
updated: 2026-09-25
source: "Projeto margemAI"
confidence: high
---

# ADR-001: Adoção de Monolito Modular em vez de Microservices Prematuros

## 1. Status
`STANDARD` (Padrão canônico de engenharia para projetos em estágio inicial e times enxutos)

---

## 2. Decisão
Adotar o estilo arquitetural **Monolito Modular** para aplicações com times de até 5 engenheiros e volumetria inicial moderada (< 1000 RPS).

* **Regras Mandatórias:**
  * Cada Bounded Context deve residir em seu próprio pacote.
  * Chamadas entre contextos devem usar DTOs e interfaces de serviço limpas.
  * O desacoplamento assíncrono deve priorizar eventos in-memory (`ApplicationEventPublisher` no Spring) antes de introduzir Message Brokers distribuídos (Kafka/RabbitMQ).
  * A comunicação com banco relacional deve preservar limites transacionais claros.

---

## 3. Rastreabilidade
* Documento de Limites: [[02-ARCHITECTURE/margemai-context-boundaries|Limites de Contexto Margem.AI]]
* Princípios: [[00-CORE/engineering-principles|Princípios de Engenharia]]
