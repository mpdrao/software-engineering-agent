# Agent Core — Context Loading & Resolution Protocol

Este módulo estabelece como o agente busca, hierarquiza e resolve contextos de conhecimento durante suas análises.

---

## 1. Hierarquia Estrita de Precedência de Contexto

Quando múltiplas fontes de informação existirem ou apresentarem regras divergentes, o agente deve aplicar rigorosamente a seguinte cadeia de prioridade:

```text
       ┌──────────────────────────────────────────────┐
  1    │       CURRENT PROJECT CONTEXT                │  (Prioridade Máxima)
       │       (PROJECTS/<project>/context.md)        │
       └──────────────────────┬───────────────────────┘
                              │
       ┌──────────────────────▼───────────────────────┐
  2    │       PROJECT DECISIONS & ADRs               │
       │       (PROJECTS/<project>/decisions/)        │
       └──────────────────────┬───────────────────────┘
                              │
       ┌──────────────────────▼───────────────────────┐
  3    │       GLOBAL STANDARDS (BRAIN)               │
       │       (BRAIN/* com status: standard)         │
       └──────────────────────┬───────────────────────┘
                              │
       ┌──────────────────────▼───────────────────────┐
  4    │       GENERAL KNOWLEDGE                      │  (Prioridade Mínima)
       │       (Conhecimento intrínseco do modelo)    │
       └──────────────────────────────────────────────┘
```

### Justificativas de Precedência:
* Uma decisão local tomada para um projeto específico (ex.: *"Neste projeto de legado usamos JDBC direto sem ORM por restrição de memória"*) **sobrescreve** o padrão global do Brain (*"Usar Spring Data JPA"*).
* Um padrão global validado no Brain (`status: standard`) **sobrescreve** o conhecimento genérico ou opiniões genéricas da web.

---

## 2. Resolução e Não-Ocultação de Conflitos

Se houver contradição entre o contexto do projeto e um padrão global ou princípio arquitetural:

1. **Nunca Ocultar o Conflito**: O agente é proibido de silenciosamente ignorar a contradição ou forçar uma preferência sem aviso.
2. **Reportar Imediatamente**:
   * Identificar as duas fontes em conflito (ex.: `PROJECTS/app/decisions/ADR-002` vs. `BRAIN/03-CODE-QUALITY/clean-code.md`).
   * Explicar as consequências técnicas da divergência.
   * Respeitar a precedência local, mas emitir alerta técnico sobre riscos ou dívida técnica gerada.

---

## 3. Estratégia de Carregamento sob Demanda

Para evitar saturação de janela de contexto e perda de foco cognitivo:
* **Não ler todo o BRAIN indiscriminadamente**: Carregar apenas os domínios do Brain acionados pelo workflow ou pelas skills ativas.
* **Índices Primeiro**: Consultar primeiro resumos, títulos e metadados antes de injetar arquivos completos.
