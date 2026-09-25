# Software Engineering Agent OS

Infraestrutura de Agente de Engenharia de Software e Technical Lead virtual baseada em Gemini CLI / Antigravity (`agy`), estruturada sob o paradigma **Brain + Skills + Workflows + Quality Gates**.

O repositório é projetado para atuar como um **Operating System de Engenharia de Software**, mantendo persistência de conhecimento técnico em Markdown puro interoperável com o **Obsidian** (Cofre `descomplicaAI`).

---

## 1. Princípio Arquitetural

A infraestrutura desacopla o comportamento cognitivo do agente em componentes modulares e determinísticos:

```text
AGENT CORE
    +
SKILLS
    +
BRAIN (Obsidian Vault)
    +
PROJECT CONTEXT
    +
WORKFLOWS
    +
QUALITY GATES
```

---

## 2. Visão Geral dos Componentes

| Diretório | Responsabilidade | Formato / Integração |
| :--- | :--- | :--- |
| `AGENT/` | Identidade, heurísticas de decisão, regras de contexto e gestão de conhecimento | Markdown estruturado (`AGENT.md`) |
| `BRAIN/` | Cofre de conhecimento persistente, padrões, ADRs e lições aprendidas | Mapeado diretamente ao cofre Obsidian via junção NTFS |
| `SKILLS/` | Especialistas autônomos por domínio com procedimentos e anti-padrões | Arquivos `SKILL.md` autocontidos |
| `WORKFLOWS/` | Protocolos de execução orientados a comando (`/audit`, `/review`, `/sdd`) | Checklists e sequências de análise |
| `QUALITY-GATES/`| Matriz de severidade (P0-P3) e critérios de liberação (`PASS`, `REVIEW`, `BLOCKED`)| Portões de qualidade objetivos |
| `TEMPLATES/` | Esqueletos padronizados para ADRs, lições, especificações e relatórios | Metadados YAML / Frontmatter |
| `PROJECTS/` | Contextos locais de cada projeto analisado | Especificações, decisões e learnings locais |

---

## 3. Modelo de Ciclo de Vida do Conhecimento

O conhecimento técnico armazenado no `BRAIN/` evolui em 3 estágios estritos:

```text
    [99-INBOX] (Candidate)
            │
            ▼
    [Validação / Evidência Prática] (Validated)
            │
            ▼
    [Padrão Global Reutilizável] (Standard)
            │
            ▼
    [Obsoleto / Substituído] (Deprecated)
```

Nenhuma hipótese gerada pelo agente torna-se `standard` automaticamente sem validação e evidências concretas.

---

## 4. Integração com Obsidian

O diretório `BRAIN/` é uma junção NTFS conectada diretamente ao cofre:
`C:\Users\mario\descomplicaAI\descompliaAI`

Isso permite:
* Navegação humana via **Obsidian Graph View**, tags e wikilinks `[[nota]]`.
* Geração, leitura e atualização de conhecimento em tempo real pelo agente.
* Versionamento Git do conhecimento técnico acumulado entre projetos.
