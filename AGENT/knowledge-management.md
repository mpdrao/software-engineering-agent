# Agent Core — Knowledge Management & Brain Lifecycle

Este módulo governa a persistência, classificação, evolução e governança do conhecimento técnico armazenado no `BRAIN/` (integrado ao Obsidian).

---

## 1. Princípio Fundamental do Brain

O `BRAIN/` **NÃO é um dump de conversas** nem um diário efêmero. Ele armazena exclusivamente:
* Decisões arquiteturais fundamentadas;
* Princípios técnicos validados;
* Padrões de design aplicados;
* Anti-padrões identificados com soluções documentadas;
* Post-mortems e lições aprendidas com bugs críticos;
* Diretrizes de segurança, performance e testes.

Toda informação deve ser concisa, atômica, modular e navegável via Obsidian.

---

## 2. O Ciclo em Três Estágios do Conhecimento

Nenhum conhecimento gerado pelo agente é tratado como verdade absoluta imediatamente. O ciclo segue uma progressão determinística:

```text
    ┌──────────────┐
    │  CANDIDATE   │  -> Descoberta inicial, hipótese ou solução local em 99-INBOX
    └──────┬───────┘
           │ (Revisão humana, testes ou reincidência confirmada)
           ▼
    ┌──────────────┐
    │  VALIDATED   │  -> Confirmado tecnicamente; movido para pasta de domínio
    └──────┬───────┘
           │ (Instituído formalmente como diretriz de engenharia)
           ▼
    ┌──────────────┐
    │   STANDARD   │  -> Regra canônica aplicável a todos os projetos
    └──────┬───────┘
           │ (Substituído por evolução técnica ou padrão superior)
           ▼
    ┌──────────────┐
    │  DEPRECATED  │  -> Obsoleto; preservado apenas para histórico
    └──────────────┘
```

---

## 3. Schema Padrão de Frontmatter YAML

Todos os documentos persistidos no Brain devem conter metadados compatíveis com o Obsidian:

```yaml
---
type: principle | pattern | anti-pattern | decision | learning | bug | security | performance | architecture | technology | standard
status: candidate | validated | standard | deprecated
domain: sdd | architecture | code-quality | security | testing | performance | stack | devops
tags: [tag1, tag2]
created: YYYY-MM-DD
updated: YYYY-MM-DD
source: project-name / ticket / audit-id
confidence: high | medium | low
---
```

---

## 4. O Fluxo de Captura em `99-INBOX`

Quando o agente descobre um comportamento não documentado, um padrão promissor ou uma solução engenhosa:
1. Ele cria uma nota em `BRAIN/99-INBOX/` com `status: candidate`.
2. O agente informa o usuário:
   > *"Registrei a descoberta em `BRAIN/99-INBOX/<arquivo>.md` como CANDIDATE para sua revisão no Obsidian."*
3. O conhecimento **nunca** é promovido para as pastas `00-CORE` até `09-DECISIONS` sem passar por validação.

---

## 5. Learning Loop Conceitual

Durante qualquer ciclo de engenharia ou resolução de incidentes:

$$\text{Problem} \longrightarrow \text{Investigation} \longrightarrow \text{Solution} \longrightarrow \text{Validation} \longrightarrow \text{Learning} \longrightarrow \text{Brain}$$

O agente avalia proativamente ao final de análises ou correções de bugs complexos:
* *"Este problema decorreu de uma premissa oculta ou anti-pattern?"*
* *"A solução é reutilizável em outros cenários?"*
* Se sim, gera o artefato correspondente no Inbox.
