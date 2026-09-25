# Quality Gates — Veredito e Regras de Transição

Este documento formaliza as regras determinísticas de decisão do **Quality Gate**. O veredito do portão governa a aprovação de Pull Requests, pipelines de CI/CD e auditorias de código.

---

## 1. Os Três Vereditos Possíveis

```text
       ┌───────────┐
       │   PASS    │  -> Aprovado para merge e deploy contínuo.
       └───────────┘
       ┌───────────┐
       │  REVIEW   │  -> Bloqueado para merge automático; requer aprovação técnica explícita.
       └───────────┘
       ┌───────────┐
       │  BLOCKED  │  -> Reprovado compulsoriamente. Merge e deploy estritamente proibidos.
       └───────────┘
```

---

## 2. Regras Matemáticas de Transição

O cálculo do veredito é estritamente baseado no somatório de findings por severidade:

$$\text{Verdict} = \begin{cases} 
\mathbf{BLOCKED}, & \text{se } \text{count}(P0) > 0 \;\lor\; \text{count}(P1) > 0 \\
\mathbf{REVIEW},  & \text{se } \text{count}(P0) = 0 \;\land\; \text{count}(P1) = 0 \;\land\; \text{count}(P2) > 0 \\
\mathbf{PASS},    & \text{se } \text{count}(P0) = 0 \;\land\; \text{count}(P1) = 0 \;\land\; \text{count}(P2) = 0
\end{cases}$$

---

## 3. Comportamento Operacional por Veredito

### BLOCKED (Bloqueado)
* **Condição**: Ao menos um finding **P0 (Blocker)** OU **P1 (Critical)** detectado.
* **Ação do Agente**:
  * Emite alerta imediato de bloqueio com lista prioritária dos problemas fatais.
  * O PR não pode ser aprovado.
  * O agente fornece as instruções e snippets de código necessários para a remediação imediata.

### REVIEW (Sob Revisão Humana)
* **Condição**: Nenhum P0/P1, mas existem findings **P2 (Important)**.
* **Ação do Agente**:
  * Emite parecer com ressalvas.
  * Se os apontamentos P2 forem aceitos como dívida técnica deliberada, o Tech Lead humano pode aprovar mediante criação de issue no backlog ou registro de **ADR/Learning Candidate**.

### PASS (Aprovado)
* **Condição**: Zero P0, zero P1 e zero P2.
* **Ação do Agente**:
  * Emite aprovação total (`APPROVED`).
  * Apontamentos P3 remanescentes são apresentados como sugestões opcionais sem caráter impeditivo.
