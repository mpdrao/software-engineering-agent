# Workflow: /architect

---

## 1. Objetivo
Projetar, avaliar ou documentar a arquitetura técnica de um sistema, módulo ou integração complexa, formalizando diagramas de limites de contexto e emitindo Architecture Decision Records (ADRs) fundamentados com trade-offs explícitos.

---

## 2. Skills Utilizadas
* [SKILLS/architecture](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/architecture/SKILL.md)
* [SKILLS/security](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/security/SKILL.md)

---

## 3. Arquivos Consultados
* `PROJECTS/<projeto>/architecture/` (visões existentes).
* `PROJECTS/<projeto>/decisions/` (ADRs históricas).
* `BRAIN/02-ARCHITECTURE/` (padrões globais).
* `TEMPLATES/architecture.md` e `TEMPLATES/adr.md`.

---

## 4. Sequência de Análise
1. **Definição de Requisitos Não-Funcionais**: Clarificar SLAs, volumetria, latência esperada, limites de segurança e tolerância a falhas.
2. **Avaliação Anti-Overengineering (Filtro de 5 Perguntas)**:
   * Responder estritamente às 5 perguntas de [AGENT/decision-making.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/decision-making.md).
   * Descartar soluções hiper-complexas prematuras (microservices desnecessários, CQRS forçado).
3. **Modelagem de Limites & Componentes**:
   * Elaborar diagramas C4 (Contexto e Containers) via Mermaid.
   * Definir contratos de comunicação (síncrona vs. assíncrona).
4. **Mapeamento de Trade-offs & Alternativas**:
   * Avaliar no mínimo 2 alternativas viáveis, documentando explicitamente por que a alternativa descartada não foi eleita.
5. **Formalização da Decisão (ADR)**:
   * Gerar documento `ADR-XXX` em `PROJECTS/<projeto>/decisions/` ou candidato no Brain.

---

## 5. Formato da Saída
* Documento de arquitetura seguindo [TEMPLATES/architecture.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/architecture.md).
* ADR seguindo [TEMPLATES/adr.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/adr.md).

---

## 6. Condições de Sucesso
* Decisão justificada com ganhos e custos documentados.
* Diagrama Mermaid sintaticamente válido gerado.
* Nenhuma abstração introduzida sem problema real comprovado.
