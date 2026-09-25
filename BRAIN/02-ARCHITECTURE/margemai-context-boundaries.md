---
type: architecture
status: validated
domain: architecture
id: ARCH-001
title: "Limites de Contexto e Bounded Contexts — Margem.AI"
tags: [architecture, ddd, bounded-contexts, sebrae, margemai]
created: 2026-09-25
updated: 2026-09-25
source: "Projeto margemAI"
confidence: high
---

# Limites de Contexto e Bounded Contexts — Margem.AI

## 1. Visão Geral da Arquitetura
O **Margem.AI** é modelado sob a arquitetura de **Monolito Modular**, integrando regras tributárias e de precificação do SEBRAE para Microempreendedores Individuais.

```mermaid
flowchart TB
    subgraph IAM ["🔑 1. Identidade & Acesso"]
        User["User & Auth"]
        Segment["Segment"]
    end

    subgraph Catalog ["📦 2. Catálogo & Padrões"]
        Product["Product"]
        Category["Category (Padrão Herdável)"]
    end

    subgraph Costs ["💰 3. Gestão de Custos"]
        FixedCost["FixedCost"]
        VariableCost["VariableCost"]
        CostProfile["FixedCostProfile"]
    end

    subgraph PricingEngine ["🧮 4. Motor de Precificação SEBRAE"]
        PricingService["PricingService"]
        MarkupCalc["Markup Divisor / Multiplicador"]
        DiscountSim["Simulador de Descontos"]
    end

    IAM -->|userId via JWT| Catalog
    IAM -->|userId via JWT| Costs
    IAM -->|userId via JWT| PricingEngine
    
    Catalog -->|Custo Efetivo| PricingEngine
    Costs -->|Rateio Automático % R_cf| PricingEngine
    Costs -.->|Eventos In-Memory| CostProfile
```

---

## 2. Decisão Arquitetural Vinculada
* [[09-DECISIONS/ADR-001-modular-monolith|ADR-001: Adoção de Monolito Modular em vez de Microservices]]
* [[00-CORE/engineering-principles|Princípios de Engenharia do SE-OS]]
