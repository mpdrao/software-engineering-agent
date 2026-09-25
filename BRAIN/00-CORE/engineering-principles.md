---
type: principle
status: standard
domain: sdd
tags: [core, principles, engineering, architecture]
created: 2026-09-25
updated: 2026-09-25
source: "Agent Core / System"
confidence: high
---

# Princípios Fundamentais de Engenharia de Software

Este documento define os sete princípios inegociáveis de engenharia de software adotados no **Software Engineering Operating System**. Eles orientam toda tomada de decisão técnica, revisão de código e auditoria arquitetural.

---

## 1. Correctness (Correção Funcional)
O software deve executar estritamente o comportamento pretendido pelo negócio sem comportamentos indefinidos, exceções não tratadas ou efeitos colaterais mascarados.
* A corretude precede qualquer otimização de performance.
* Verificação contínua via [[sdd-methodology|Metodologia SDD]].

---

## 2. Simplicity (Simplicidade Essencial)
A complexidade acidental é a maior fonte de falhas e lentidão no ciclo de vida de software.
* Praticar ativamente os princípios **KISS** (*Keep It Simple, Stupid*) e **YAGNI** (*You Aren't Gonna Need It*).
* A solução mais simples que atende aos requisitos atuais com clareza é sempre superior a uma arquitetura rebuscada projetada para necessidades hipotéticas futuras.
* Consulte o filtro de 5 perguntas em [[AGENT/decision-making]].

---

## 3. Maintainability (Manutenibilidade & Sustentabilidade)
O código é lido com frequência exponencialmente maior do que é escrito.
* Nomenclatura reveladora de intenção e funções pequenas com nível único de abstração (SLAP).
* Respeito às diretrizes de [[SKILLS/clean-code/SKILL|Clean Code]] e [[SKILLS/solid/SKILL|SOLID]].

---

## 4. Security by Design (Segurança por Padrão)
A segurança não é uma camada adicionada ao final, mas uma propriedade intrínseca da construção.
* Tratar toda entrada externa como potencialmente maliciosa (validação na borda).
* Menor privilégio operacional em banco de dados, credenciais e permissões.
* Zero tolerância com vulnerabilidades críticas ([[QUALITY-GATES/severity|Matriz P0/P1]]).

---

## 5. Testability (Testabilidade como Requisito de Design)
Se um componente é difícil de testar de forma isolada, rápida e determinística, sua arquitetura está defeituosa.
* Pirâmide de testes equilibrada com asserções semânticas precisas.
* Combate rigoroso a testes instáveis (*flaky tests*) e dependências temporais arbitrárias.
* Consulte [[SKILLS/testing/SKILL|Diretrizes de Testes]].

---

## 6. Observability (Observabilidade em Produção)
Sistemas complexos devem permitir a inferência do seu estado interno a partir de suas saídas operacionais.
* Logs estruturados em formato JSON com contexto de correlação (`traceId`, `spanId`).
* Métricas semânticas de latência, taxa de erro e throughput.

---

## 7. Evolvability (Evolutividade Arquitetural)
O design deve permitir a evolução do sistema sem exigir refatorações destrutivas em cascata.
* Desacoplamento entre regras de negócio centrais e detalhes de infraestrutura (bancos, frameworks, UI).
* Registro formal de decisões técnicas através de [[TEMPLATES/adr|ADRs]].
