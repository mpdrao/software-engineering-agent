---
type: anti-pattern
status: candidate
domain: performance
id: ANT-002
title: "Transação de Escrita Desnecessária em Consulta de Leitura (Write-in-Read Trap)"
tags: [performance, spring-boot, jpa, transactions, anti-pattern, candidate]
created: 2026-09-25
updated: 2026-09-25
source: "Workflow /performance margemAI"
confidence: high
---

# ANT-002: Transação de Escrita em Rota de Consulta de Leitura (Write-in-Read Trap)

## 1. Problema Observado
No backend do projeto **Margem.AI**, o endpoint de cálculo de precificação (`POST /v1/pricing/calculate`) é conceitualmente uma operação estritamente analítica e de leitura. No entanto, quando acionado com `useAutomaticFixedCosts = true`, o fluxo aciona:

```java
// PricingService.java
BigDecimal fixedPercent = resolveFixedPercent(request, userId);

// FixedCostProfileService.java
@Transactional
public BigDecimal getEffectiveFixedCostPercent(UUID userId) {
    return recalculate(userId).getAllocatedFixedCostPercent();
}
```

O método `recalculate(userId)` dispara:
1. Uma consulta agregada no banco: `fixedCostRepository.sumActiveAmountByUserId(userId)`.
2. Um recálculo aritmético.
3. Um comando `UPDATE` no banco via `profileRepository.save(profile)`.

---

## 2. Diagnóstico & Impacto
* **Mecanismo da Falha**: A rota de cálculo analítico abre uma transação de escrita desnecessária, gerando locks de linha no PostgreSQL e I/O de disco a cada simulação feita pelo usuário.
* **Redundância**: A aplicação já possui um listener reativo `@EventListener public void onFixedCostsRecalculated(...)` que recalcula o perfil no momento exato em que um custo fixo é criado, alterado ou excluído.
* **Impacto**: Degradação drástica de throughput sob concorrência e desperdício de conexões transacionais de escrita para operações puramente consultivas.

---

## 3. Solução Canônica & Refatoração

Na leitura da taxa, deve-se ler o snapshot já persistido no perfil sem forçar novo recálculo e sem abrir transação de escrita:

### Antes (Problemático)
```java
@Transactional
public BigDecimal getEffectiveFixedCostPercent(UUID userId) {
    return recalculate(userId).getAllocatedFixedCostPercent();
}
```

### Depois (Otimizado $O(1)$)
```java
@Transactional(readOnly = true)
public BigDecimal getEffectiveFixedCostPercent(UUID userId) {
    return profileRepository.findByUserId(userId)
            .map(FixedCostProfile::getAllocatedFixedCostPercent)
            .orElse(BigDecimal.ZERO);
}
```

O recálculo via `recalculate(userId)` permanece ativo apenas quando os custos fixos realmente sofrerem mutação (via `@EventListener`).

---

## 4. Rastreabilidade
* Origem: `[[PROJECTS/margemAI/context]]`
* Princípio: `[[00-CORE/engineering-principles]]`
