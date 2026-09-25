---
type: requirement
status: candidate # candidate | validated | standard | deprecated
domain: sdd
id: REQ-000
title: "Título Conciso do Requisito"
tags: [requirement, feature]
created: YYYY-MM-DD
updated: YYYY-MM-DD
source: "Origem (User Story / Jira / Stakeholder)"
confidence: high # high | medium | low
---

# REQ-000: Título do Requisito

## 1. Descrição do Requisito
Breve declaração do valor para o negócio e usuário:
> **Como** [papel do usuário],  
> **Eu quero** [funcionalidade / ação],  
> **Para que** [benefício / valor gerado].

---

## 2. Contexto e Motivação
Explicação técnica e de domínio sobre a necessidade desta funcionalidade e eventuais impactos no ecossistema atual.

---

## 3. Critérios de Aceitação (Gherkin)

### Cenário 1: [Cenário Principal / Happy Path]
* **Dado** [pré-condição do sistema]
* **Quando** [evento ou ação do usuário]
* **Então** [resultado esperado observável]

### Cenário 2: [Cenário de Exceção / Borda]
* **Dado** [pré-condição com dados inválidos ou limite]
* **Quando** [ação de submissão]
* **Então** [mensagem de erro explícita e código de status correspondente]

---

## 4. Restrições e Requisitos Não-Funcionais
* **Performance**: Tempo de resposta máximo tolerado (ex.: $p95 < 200ms$).
* **Segurança**: Permissões/Roles exigidas (ex.: `ROLE_ADMIN`), sanitização de inputs.
* **Compatibilidade**: Browsers suportados, versões de API ou persistência.

---

## 5. Rastreabilidade SDD
* **Especificação Associada**: `[[SPEC-000]]`
* **Implementação Prevista**: `[[ComponenteOuClasse]]`
* **Testes de Validação**: `[[TesteUnitarioOuIntegracao]]`
* **Status de Cobertura**: `NÃO_IMPLEMENTADO` <!-- CONFORME | PARCIALMENTE_CONFORME | DIVERGENTE | NÃO_IMPLEMENTADO | NÃO_VERIFICÁVEL -->
