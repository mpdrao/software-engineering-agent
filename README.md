# Software Engineering Operating System (SE-OS)

> **Autonomous Virtual Tech Lead & Software Engineering Agent**  
> Infraestrutura de Engenharia de Software baseada em **Gemini CLI / Antigravity (`agy`)** integrada com cérebro em Markdown interoperável com o **Obsidian** (Cofre `descomplicaAI`).

---

## 1. Missão & Visão

O **Software Engineering Operating System** não é um chatbot convencional para responder dúvidas de programação. Trata-se de uma infraestrutura corporativa autônoma para atuar como **Virtual Technical Lead / Staff Software Engineer**, capaz de:
* Compreender e validar especificações de negócio (**SDD**);
* Auditar código e arquitetura sem alucinações de contexto;
* Aplicar princípios inegociáveis de **Clean Code**, **SOLID** e **OWASP Security**;
* Fazer a gestão de decisões técnicas (**ADRs**) e ciclo de vida de lições aprendidas;
* Decidir vereditos determinísticos de liberação através de **Quality Gates** (`PASS`, `REVIEW`, `BLOCKED`);
* Acumular e transferir conhecimento persistente entre projetos através do **Obsidian Brain**.

---

## 2. Arquitetura do Sistema

O sistema é estritamente modular e desacoplado:

```text
                           USUÁRIO / TECH LEAD
                                   │
                                   ▼
             ┌───────────────────────────────────────────┐
             │       GEMINI CLI / ANTIGRAVITY (AGY)      │
             └─────────────────────┬─────────────────────┘
                                   │
                                   ▼
             ┌───────────────────────────────────────────┐
             │                AGENT CORE                 │
             │   Identidade • Heurísticas • Governança   │
             └──────┬──────────────────────┬─────────────┘
                    │                      │
       ┌────────────┴────────┐    ┌────────┴────────────┐
       ▼                     ▼    ▼                     ▼
┌──────────────┐     ┌──────────────┐    ┌──────────────────┐
│    SKILLS    │     │  WORKFLOWS   │    │  QUALITY GATES   │
│ Especialistas│     │  Comandos &  │    │  P0 - P3 Matriz  │
│  Autônomos   │     │  Protocolos  │    │   Veredito Real  │
└──────┬───────┘     └──────┬───────┘    └────────┬─────────┘
       │                    │                     │
       └────────────┬───────┴─────────────────────┘
                    ▼
┌───────────────────────────────────────────────────────────┐
│                 CONTEXTO & PERSISTÊNCIA                   │
│                                                           │
│  [PROJECT CONTEXT]                 [BRAIN / OBSIDIAN]     │
│  - Specs (SPEC-XXX)                - 00 a 10 Domínios     │
│  - ADRs Locais                     - 99-INBOX (Candidate) │
│  - Target Codebase                 - Markdown Puro / Grafo│
└───────────────────────────────────────────────────────────┘
```

---

## 3. Estrutura de Diretórios

```text
software-engineering-agent/
│
├── README.md                      # Este manual executivo
├── AGENT.md                       # Ponto de entrada do Agent Core
│
├── AGENT/                         # Governança e Cognição do Agente
│   ├── system.md                  # Identidade, papéis e princípios inegociáveis
│   ├── behavior.md                # Postura investigativa baseada em evidências
│   ├── decision-making.md         # Filtro de 5 perguntas anti-overengineering
│   ├── context-loading.md         # Precedência estrita de contexto
│   └── knowledge-management.md   # Ciclo de vida Candidate -> Validated -> Standard
│
├── BRAIN/                         # Junção NTFS -> C:\Users\mario\descomplicaAI\descompliaAI
│   ├── 00-CORE/                   # Princípios e metodologia SDD
│   ├── 01-SDD/                    # Especificações globais
│   ├── 02-ARCHITECTURE/           # Estilos e padrões arquiteturais globais
│   ├── 03-CODE-QUALITY/           # Clean code e diretrizes de sustentabilidade
│   ├── 04-SECURITY/               # Práticas OWASP e matrizes de vulnerabilidade
│   ├── 05-TESTING/                # Pirâmide de testes e asserções semânticas
│   ├── 06-PERFORMANCE/            # Complexidade algorítmica e persistência
│   ├── 07-STACK/                  # Padrões específicos de tecnologia
│   ├── 08-PATTERNS/               # Design patterns e anti-patterns com soluções
│   ├── 09-DECISIONS/              # ADRs globais aprovadas
│   ├── 10-LEARNINGS/              # Post-mortems e lições de incidentes
│   └── 99-INBOX/                  # Capturas brutas e hipóteses (Candidate)
│
├── SKILLS/                        # Habilidades Especializadas Autônomas
│   ├── sdd/SKILL.md               # Rastreabilidade Requisito -> Código -> Teste
│   ├── architecture/SKILL.md      # Limites, acoplamento, coesão e ADRs
│   ├── code-review/SKILL.md       # Inspeção crítica de PRs e código alterado
│   ├── clean-code/SKILL.md        # Nomenclatura, SLAP e Guard Clauses
│   ├── solid/SKILL.md             # Auditoria pragmática de SRP, OCP, LSP, ISP, DIP
│   ├── security/SKILL.md          # Auditoria SAST orientada a OWASP Top 10
│   └── testing/SKILL.md           # Qualidade, determinismo e cobertura semântica
│
├── WORKFLOWS/                     # Protocolos de Execução
│   ├── analyze.md                 # Investigação técnica sob demanda (/analyze)
│   ├── architect.md               # Modelagem de arquitetura e ADR (/architect)
│   ├── sdd.md                     # Auditoria de conformidade de requisitos (/sdd)
│   ├── review.md                  # Revisão de Pull Request / diff (/review)
│   ├── security.md                # Auditoria estática de vulnerabilidades (/security)
│   ├── testing.md                 # Diagnóstico de suíte de testes (/test)
│   ├── performance.md             # Identificação de gargalos e N+1 (/performance)
│   ├── refactor.md                # Refatoração segura Red-Green-Refactor (/refactor)
│   └── audit.md                   # Auditoria mestre de 15 etapas (/audit)
│
├── QUALITY-GATES/                 # Portões de Qualidade Determinísticos
│   ├── severity.md                # Matriz de P0 (Blocker) a P3 (Improvement)
│   ├── gate.md                    # Regras matemáticas PASS, REVIEW, BLOCKED
│   └── checklist.md               # Checklist de liberação de engenharia
│
├── TEMPLATES/                     # Modelos com Frontmatter YAML para Obsidian
│   ├── requirement.md             # Requisito de negócio estruturado (REQ-XXX)
│   ├── specification.md           # Especificação técnica (SPEC-XXX)
│   ├── architecture.md            # Visão de arquitetura com diagramas C4
│   ├── adr.md                     # Architecture Decision Record (ADR-XXX)
│   ├── learning.md                # Lição aprendida / post-mortem (LRN-XXX)
│   ├── pattern.md                 # Design Pattern estruturado
│   ├── anti-pattern.md            # Anti-pattern com diagnóstico e refatoração
│   └── audit-report.md            # Relatório formal de auditoria técnica
│
└── PROJECTS/                      # Contextos Locais de Projetos Auditados
    └── _template/                 # Modelo para onboarding de novos projetos
        ├── context.md             # Visão geral, SLAs e exceções locais
        ├── specification/
        ├── architecture/
        ├── decisions/
        └── learnings/
```

---

## 4. Integração com Obsidian (`descomplicaAI`)

O diretório `BRAIN/` está mapeado diretamente ao seu cofre do Obsidian através de uma Junção NTFS de Diretório:
`software-engineering-agent\BRAIN` $\Longleftrightarrow$ `C:\Users\mario\descomplicaAI\descompliaAI`

### Recursos Nativos do Obsidian Utilizados:
1. **Frontmatter YAML Estrito**: Permite filtros avançados via plugins como Dataview ou busca por propriedades nativas do Obsidian.
2. **Graph View (Grafo de Conhecimento)**: Relações expressas com links bidirecionais `[[nota]]` geram um mapa visual vivo de como ADRs, requisitos e lições se conectam.
3. **Ciclo em Três Estágios**:
   * O agente registra descobertas em `99-INBOX/` com `status: candidate`.
   * Você revisa e valida no Obsidian mudando para `status: validated`.
   * Padrões corporativos são consolidados nas pastas de domínio com `status: standard`.

---

## 5. Como Operar com Gemini CLI (`agy`)

### Exemplo 1: Auditoria Completa de um Projeto
No terminal do projeto ou via comando do agente:
```bash
# Executa a auditoria completa de 15 etapas (estritamente read-only)
Execute o workflow /audit sobre o projeto no caminho C:/Users/mario/.../meu-projeto
```

### Exemplo 2: Validação de Especificação (SDD)
```bash
# Valida se a implementação cumpre os requisitos
Execute o workflow /sdd validando a especificação SPEC-001 contra o pacote com.app.billing
```

### Exemplo 3: Revisão de Pull Request / Alteração
```bash
# Revisa um trecho ou diff recente
Execute o workflow /review nos arquivos alterados
```

---

## 6. Portões de Qualidade (Quality Gates)

O veredito final é calculado matematicamente:

| Veredito | Condição | Ação de Governança |
| :---: | :--- | :--- |
| **`BLOCKED`** | $\text{count}(P0) > 0 \lor \text{count}(P1) > 0$ | Merge e deploy estritamente proibidos. Correção imediata necessária. |
| **`REVIEW`** | $\text{count}(P0) = 0 \land \text{count}(P1) = 0 \land \text{count}(P2) > 0$ | Bloqueado para merge automático. Requer aprovação técnica humana. |
| **`PASS`** | $\text{count}(P0) = 0 \land \text{count}(P1) = 0 \land \text{count}(P2) = 0$ | Aprovado para merge e deploy contínuo. |
