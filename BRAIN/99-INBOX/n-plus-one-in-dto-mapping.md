---
type: anti-pattern
status: candidate
domain: performance
id: ANT-001
title: "Anti-Padrão N+1 em Mapeamento DTO de Resultados Paginados"
tags: [performance, jpa, hibernate, n-plus-one, spring-boot, candidate]
created: 2026-09-25
updated: 2026-09-25
source: "Auditoria margemAI"
confidence: high
---

# ANT-001: Consulta N+1 em Mapeamento DTO Paginado

## 1. Problema Observado
Durante a auditoria do **Margem.AI**, foi detectada a ocorrência do anti-padrão **N+1 queries** dentro do método de conversão de entidades para DTO (`toResponse`):

```java
Page<Product> result = productRepository.findAll(spec, pageable);
return PaginatedResponse.from(result, product -> toResponse(product, userId));
```

Dentro da função `toResponse`:
```java
List<VariableCost> variableCosts = variableCostRepository
    .findByProductIdAndUserIdAndActiveTrue(product.getId(), userId);
```

---

## 2. Diagnóstico & Impacto
* **Mecanismo da Falha**: Para uma página contendo 20 produtos, o Hibernate executa 1 consulta para obter os produtos e mais 20 consultas subsequentes no banco de dados para buscar os custos variáveis de cada produto.
* **Impacto**: Latência multiplicada por 20 vezes, exaustão precoce do pool de conexões (HikariCP) e gargalo severo de I/O em ambientes de alta concorrência.

---

## 3. Solução Canônica & Refatoração (Batch Fetching)

Em vez de consultar o banco dentro do loop do stream:
1. Extrair os IDs de todos os produtos retornados na página atual:
   ```java
   List<UUID> productIds = result.getContent().stream().map(Product::getId).toList();
   ```
2. Buscar todos os custos variáveis desses produtos em uma única consulta SQL com `IN`:
   ```java
   List<VariableCost> allCosts = variableCostRepository
       .findByProductIdInAndUserIdAndActiveTrue(productIds, userId);
   ```
3. Agrupar em memória via `Collectors.groupingBy` em $O(n)$:
   ```java
   Map<UUID, List<VariableCost>> costsByProduct = allCosts.stream()
       .collect(Collectors.groupingBy(VariableCost::getProductId));
   ```
4. Passar a lista pré-agrupada para o método `toResponse`:
   ```java
   return PaginatedResponse.from(result, product -> 
       toResponse(product, costsByProduct.getOrDefault(product.getId(), List.of()))
   );
   ```
* **Resultado**: Redução de 21 consultas para **exatamente 2 consultas SQL**.

---

## 4. Rastreabilidade
* Origem: `[[PROJECTS/margemAI/context]]`
* Princípio: `[[00-CORE/engineering-principles]]`
