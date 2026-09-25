---
type: standard
status: candidate # candidate | validated | standard | deprecated
domain: architecture
id: AUDIT-000
title: "Relatório Consolidado de Auditoria Técnica"
tags: [audit, report, code-review, quality-gate]
created: YYYY-MM-DD
updated: YYYY-MM-DD
source: "Workflow /audit"
confidence: high
---

# Analysis: [Nome do Projeto / Módulo]

## 1. Context
* **Data da Análise**: YYYY-MM-DD
* **Alvo Auditado**: `src/` ou repositório
* **Workflow Utilizado**: `/audit`
* **Skills Mobilizadas**: `sdd`, `architecture`, `code-review`, `clean-code`, `solid`, `security`, `testing`
* **Especificações e ADRs Consultadas**: `[[SPEC-001]]`, `[[ADR-001]]`

---

## 2. Findings

### FND-001: [Título Conciso do Finding]
* **ID**: FND-001
* **Severity**: `P0 - BLOCKER` <!-- P0 - BLOCKER | P1 - CRITICAL | P2 - IMPORTANT | P3 - IMPROVEMENT -->
* **Location**: `src/main/java/com/app/service/PaymentService.java#L45-L62`
* **Problem**: [Descrição objetiva do defeito, vulnerabilidade ou violação]
* **Evidence**:
  ```java
  // Trecho de código comprovando a falha
  ```
* **Impact**: [Consequência no sistema: vulnerabilidade a SQL Injection, vazamento de memória, regressão funcional, etc.]
* **Recommendation**: [Ação técnica prescritiva de correção com exemplo de código seguro/correto]

### FND-002: [Título Conciso do Finding]
* **ID**: FND-002
* **Severity**: `P2 - IMPORTANT`
* **Location**: `src/main/java/com/app/controller/OrderController.java#L88`
* **Problem**: Falta de validação de tamanho de payload no DTO de entrada.
* **Evidence**: Objeto recebido com `@RequestBody OrderDto` sem anotações `@Valid` ou Bean Validation.
* **Impact**: Risco de inconsistência de dados no banco e potencial DoS por payload excessivo.
* **Recommendation**: Adicionar anotações `@Valid` e `@Size(max = 100)` nos campos correspondentes.

---

## 3. Architecture
* **Conformidade Estrutural**: Avaliação do alinhamento entre a implementação e o modelo arquitetural pretendido (ex.: violação de camadas, acoplamento indevido de infraestrutura no domínio).
* **Dependências & Complexidade**: Identificação de dependências circulares ou bibliotecas com vulnerabilidades/depreciações.

---

## 4. Risks
* **Risco Operacional**: [Impacto em disponibilidade, resiliência ou sustentação]
* **Risco de Segurança**: [Exposição de dados sensíveis ou ausência de autorização]
* **Dívida Técnica**: [Custo futuro de manutenção e taxa de juros da dívida]

---

## 5. Recommendations
Plano de ação priorizado para resolução:
1. **Curto Prazo (Imediato)**: Corrigir bloqueadores P0 e P1 antes do deploy.
2. **Médio Prazo**: Refatorar pontos P2 para evitar degradação de manutenibilidade.
3. **Longo Prazo**: Modernização de stack ou melhorias cosméticas P3.

---

## 6. Quality Gate

| Veredito Final | Justificativa |
| :---: | :--- |
| **BLOCKED** <!-- PASS | REVIEW | BLOCKED --> | Presença de 1 finding P0 (Blocker) que impede a liberação segura para produção. |

* **Total P0 (Blocker)**: 1
* **Total P1 (Critical)**: 0
* **Total P2 (Important)**: 1
* **Total P3 (Improvement)**: 0

---

## 7. Knowledge Candidates
Novas descobertas sugeridas para o `BRAIN/99-INBOX/`:
* `[[99-INBOX/candidato-padrao-ou-bug]]`: Descrição concisa da descoberta para catalogação e validação no Obsidian.
