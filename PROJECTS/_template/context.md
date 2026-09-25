# Project Context: [Nome do Projeto]

---

## 1. Visão Geral do Projeto
* **Nome**: [Nome do Repositório / Sistema]
* **Domínio de Negócio**: [Fintech, E-commerce, Logística, Saúde, etc.]
* **Tech Stack Principal**: [Linguagem, Framework, Banco de Dados, Mensageria]
* **Repositório Git**: [URL ou caminho local]
* **Ambiente Principal**: [Cloud AWS/GCP/Azure / On-Premise]

---

## 2. Limites & Objetivos Críticos
* **Objetivo de Negócio**: O que este sistema viabiliza?
* **SLAs Críticos**: Latência máxima permitida, volume esperado (RPS), tolerância a perda de dados (RPO/RTO).
* **Restrições Regulatórias**: LGPD, GDPR, PCI-DSS, etc.

---

## 3. Estrutura de Diretórios Local
```text
PROJECT/
├── specification/    # Especificações de requisitos (SPEC-XXX, REQ-XXX)
├── architecture/     # Visão arquitetural e diagramas C4
├── decisions/        # Architecture Decision Records locais (ADR-XXX)
├── learnings/        # Lições aprendidas específicas deste projeto
└── context.md        # Este arquivo de contexto
```

---

## 4. Regras & Decisões Locais (Sobrescrevem Padrões Globais)
Liste aqui quaisquer restrições ou exceções locais que diferem dos padrões globais do Brain:
* Exemplo: *"Neste projeto de batch de alta vazão, usamos JDBC puro com transações manuais em vez de ORM devido à restrição de alocação de memória no container."*

---

## 5. Documentos Vinculados
* Especificações Ativas: `[[specification/SPEC-001]]`
* Arquitetura Vigente: `[[architecture/ARCH-001]]`
* ADRs Decisivas: `[[decisions/ADR-001]]`
