---
type: standard
status: standard
domain: sdd
tags: [core, sdd, methodology, specifications]
created: 2026-09-25
updated: 2026-09-25
source: "Agent Core / SDD"
confidence: high
---

# Metodologia SDD (Specification Driven Development)

Este documento define o framework de **Desenvolvimento Orientado a Especificação (SDD)**, adotado como pilar central de governança técnica no **Software Engineering Operating System**.

---

## 1. O Fluxo Unidirecional de Engenharia

O SDD estabelece que nenhuma linha de implementação existe no vácuo. Todo desenvolvimento de software deve percorrer o ciclo:

```text
    ┌───────────────┐
    │  REQUIREMENT  │  (REQ-XXX: Necessidade de negócio e critérios BDD)
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │ SPECIFICATION │  (SPEC-XXX: Contratos de API, modelos de dados e erros)
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │ ARCHITECTURE  │  (ARCH-XXX / ADR-XXX: Limites modulares e trade-offs)
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │IMPLEMENTATION │  (Classes de serviço, entidades e adaptadores)
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │     TESTS     │  (Testes automatizados cobrindo cada critério)
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │  VALIDATION   │  (Workflow /sdd gerando veredito de conformidade)
    └───────────────┘
```

---

## 2. A Tríade de Rastreabilidade

Para cada requisito atômico, o agente exige a existência da tríade:

$$\text{Requisito} \longleftrightarrow \text{Implementação} \longleftrightarrow \text{Teste}$$

A auditoria categoriza o estado de conformidade em cinco classes normativas:
1. **`CONFORME`**: Implementação fiel com testes automatizados aprovados.
2. **`PARCIALMENTE_CONFORME`**: Implementado, mas sem testes adequados ou com cenários de borda pendentes.
3. **`DIVERGENTE`**: O código produz resultado conflitante com a especificação (Finding P1).
4. **`NÃO_IMPLEMENTADO`**: Requisito ausente no código de produção.
5. **`NÃO_VERIFICÁVEL`**: Requisito ambíguo que não permite validação determinística.

---

## 3. Gestão de Mudança e Versionamento de Requisitos

* Se o código precisar mudar por nova necessidade de negócio, a **especificação deve ser atualizada primeiro**.
* É terminantemente proibido alterar comportamento de regras de negócio no código sem a correspondente evolução documental.
* Consulte o workflow [[WORKFLOWS/sdd|Workflow /sdd]].
