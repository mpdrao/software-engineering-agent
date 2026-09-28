# Software Engineering Operating System (SE-OS)

> **Autonomous Virtual Tech Lead & Software Engineering Agent**  
> Infraestrutura de Engenharia de Software baseada em **Gemini CLI / Antigravity (`agy`)** integrada com cérebro em Markdown interoperável com o **Obsidian**.

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

## 3. Configuração Dinâmica do Ambiente (Quickstart)

O SE-OS suporta parametrização dinâmica de pastas através de variáveis de ambiente e scripts automatizados multiplataforma:

### Passo 1: Definir Variáveis de Ambiente
Copie o arquivo de exemplo:
```bash
cp .env.example .env
```
Edite o arquivo `.env` inserindo o caminho do seu cofre do Obsidian:
```properties
OBSIDIAN_VAULT_PATH=C:/Caminho/Para/Seu/Cofre
PROJECTS_ROOT_PATH=C:/Projetos
```

### Passo 2: Conectar o Cérebro (BRAIN) ao Obsidian
Execute o script correspondente ao seu sistema operacional:

* **No Windows (PowerShell):**
  ```powershell
  .\scripts\setup-brain.ps1 -VaultPath "C:\Caminho\Para\Seu\Cofre"
  ```
* **No Linux / macOS / WSL (Bash):**
  ```bash
  chmod +x ./scripts/setup-brain.sh
  ./scripts/setup-brain.sh ~/meu-cofre-obsidian
  ```

O script cria uma junção NTFS / link simbólico conectando `BRAIN/` ao seu cofre sem duplicar arquivos.

### Passo 3: Registrar as Skills Nativas (Slash Commands)
Para habilitar comandos diretos (`/audit`, `/sdd`, `/architect`, etc.) no Gemini CLI / Antigravity em qualquer pasta do seu computador:

* **No Windows (PowerShell):**
  ```powershell
  .\scripts\install-skills.ps1
  ```
* **No Linux / macOS (Bash):**
  ```bash
  chmod +x ./scripts/install-skills.sh
  ./scripts/install-skills.sh
  ```

O script instala as definições de skills em `~/.gemini/config/skills/`, ativando progressive disclosure e autocompletion nativo no CLI.

---

## 4. Estrutura de Diretórios

```text
software-engineering-agent/
│
├── README.md                      # Este manual executivo
├── AGENT.md                       # Ponto de entrada do Agent Core
├── AGENTS.md                      # Guardrails de segurança e contenção do agente
├── SECURITY.md                    # Política de segurança e reporte de vulnerabilidades
├── SELF-AUDIT-REPORT.md           # Relatório de autovalidação da infraestrutura
├── .env.example                   # Modelo de parametrização dinâmica
│
├── .agents/                       # Customizações nativas para Gemini CLI / Antigravity
│   └── skills/                    # 9 Skills nativas com progressive disclosure (/audit, /sdd, etc.)
│
├── .github/                       # Governança e CI/CD no GitHub
│   ├── CODEOWNERS                 # Propriedade de código e revisão mandatória
│   └── workflows/security.yml     # Varredura contínua de segredos (Gitleaks) e scripts
│
├── scripts/                       # Scripts de automação multiplataforma
│   ├── setup-brain.ps1            # Conexão dinâmica no Windows (NTFS Junction)
│   ├── setup-brain.sh             # Conexão dinâmica no Linux/macOS (Symlink)
│   ├── install-skills.ps1         # Instalação global de skills no Windows
│   └── install-skills.sh          # Instalação global de skills no Linux/macOS
│
├── AGENT/                         # Governança e Cognição do Agente
│   ├── system.md                  # Identidade, papéis e princípios inegociáveis
│   ├── behavior.md                # Postura investigativa baseada em evidências
│   ├── decision-making.md         # Filtro de 5 perguntas anti-overengineering
│   ├── context-loading.md         # Precedência estrita de contexto
│   └── knowledge-management.md   # Ciclo de vida Candidate -> Validated -> Standard
│
├── BRAIN/                         # Conectado dinamicamente ao seu cofre do Obsidian
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
├── SKILLS/                        # 16 Habilidades Especializadas Autônomas
│   ├── sdd/SKILL.md               # Rastreabilidade Requisito -> Código -> Teste
│   ├── architecture/SKILL.md      # Limites, acoplamento, coesão e ADRs
│   ├── code-review/SKILL.md       # Inspeção crítica de PRs e código alterado
│   ├── clean-code/SKILL.md        # Nomenclatura, SLAP e Guard Clauses
│   ├── solid/SKILL.md             # Auditoria de SRP, OCP, LSP, ISP, DIP
│   ├── security/SKILL.md          # Auditoria SAST orientada a OWASP Top 10
│   ├── testing/SKILL.md           # Qualidade, determinismo e cobertura semântica
│   ├── database/SKILL.md          # Modelagem relacional/NoSQL, índices e N+1
│   ├── devops/SKILL.md            # CI/CD, IaC, 12-factor e observabilidade
│   ├── design-patterns/SKILL.md   # Padrões GoF e combate à patternitis
│   ├── performance/SKILL.md       # Análise O(n), vazamentos e concorrência
│   ├── java-spring/SKILL.md       # Spring Boot, JPA, @Transactional e IoC
│   ├── angular/SKILL.md           # Standalone Components, Signals e RxJS
│   ├── react/SKILL.md             # Hooks, dependências, imutabilidade e memo
│   ├── docker/SKILL.md            # Multi-stage builds, non-root e .dockerignore
│   └── aws/SKILL.md               # Well-Architected, IAM menor privilégio e S3
│
├── WORKFLOWS/                     # Protocolos de Execução Detalhados
│   ├── README.md                  # Guia completo de execução e parâmetros
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

## 5. Como Operar com Gemini CLI (`agy`)

Com as skills instaladas, execute diretamente via **slash command** e passe os parâmetros de forma posicional ou por contexto:

### Exemplo 1: Auditoria Técnica Completa
```bash
/audit C:/Projetos/meu-sistema
```

### Exemplo 2: Validação de Especificação (SDD)
```bash
/sdd SPEC-001.md PricingService.java PricingServiceTest.java
```

### Exemplo 3: Revisão de Pull Request / Diff
```bash
/review HEAD~1
```

### Exemplo 4: Desenho Arquitetural e ADR
```bash
/architect "Faturamento Assíncrono" "Desacoplar emissão de cobranças com fila RabbitMQ"
```

### Exemplo 5: Diagnóstico de Desempenho e Gargalos
```bash
/performance C:/Projetos/meu-sistema/services
```

---

## 6. Portões de Qualidade (Quality Gates)

| Veredito | Condição | Ação de Governança |
| :---: | :--- | :--- |
| **`BLOCKED`** | $\text{count}(P0) > 0 \lor \text{count}(P1) > 0$ | Merge e deploy estritamente proibidos. Correção imediata necessária. |
| **`REVIEW`** | $\text{count}(P0) = 0 \land \text{count}(P1) = 0 \land \text{count}(P2) > 0$ | Bloqueado para merge automático. Requer aprovação técnica humana. |
| **`PASS`** | $\text{count}(P0) = 0 \land \text{count}(P1) = 0 \land \text{count}(P2) = 0$ | Aprovado para merge e deploy contínuo. |
