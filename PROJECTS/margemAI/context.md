# Project Context: Margem.AI

---

## 1. Visão Geral do Projeto
* **Nome**: Margem.AI (Assistente Financeiro e Precificação para MEI)
* **Domínio de Negócio**: Gestão Financeira, Precificação SEBRAE e Fluxo de Caixa para MEIs
* **Tech Stack Principal**: Java 21, Spring Boot 3.4.2, Spring Data JPA, Spring Security, PostgreSQL 16, React 19, Vite, Tailwind CSS v4
* **Repositório Git**: `${PROJECTS_ROOT_PATH}/margemAI` (ou `../margemAI`)
* **Ambiente Principal**: Cloud (Produção Trunk-Based via GitHub Actions)

---

## 2. Limites & Objetivos Críticos
* **Objetivo de Negócio**: Automatizar o cálculo de Markup Divisor/Multiplicador do SEBRAE e margem de contribuição para microempreendedores.
* **SLAs Críticos**: Latência $< 200ms$ em `/v1/pricing/calculate`.
* **Restrições Regulatórias**: LGPD (dados de CNPJ e faturamento de MEIs).

---

## 3. Histórico de Auditorias
* `[[PROJECTS/margemAI/audit-report-2026-09-25]]`: Primeira auditoria SE-OS (Veredito: `BLOCKED` por fallback de chave JWT).
