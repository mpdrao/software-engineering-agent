# Quality Gates — Checklist de Liberação de Engenharia

Este checklist sintetiza os critérios objetivos de verificação que devem ser conferidos antes de qualquer liberação de código, encerramento de auditoria ou merge de pull request.

---

## 1. Checklist por Domínio Técnico

### A. Rastreabilidade & SDD
- [ ] Todos os critérios de aceitação do requisito (`REQ-XXX`) estão implementados (`CONFORME`).
- [ ] Não existem divergências semânticas entre o código e a especificação (`SPEC-XXX`).
- [ ] Não foram introduzidas regras de negócio ocultas ou não documentadas.

### B. Arquitetura & Limites de Contexto
- [ ] Camada de Domínio / Regras Centrais não importa dependências de infraestrutura ou frameworks externos.
- [ ] Não existem dependências circulares entre pacotes ou módulos.
- [ ] As decisões tomadas respeitam as ADRs vigentes (`PROJECTS/<projeto>/decisions/`).

### C. Clean Code & Manutenibilidade
- [ ] Nomes de classes, métodos e variáveis são autoexplicativos e alinhados à linguagem ubíqua.
- [ ] Métodos operam em um único nível de abstração (SLAP) e possuem menos de 30 linhas.
- [ ] Foram aplicadas Guard Clauses eliminando aninhamentos excessivos de `if/else`.
- [ ] Métodos não utilizam parâmetros booleanos como flags de ramificação.

### D. Princípios SOLID
- [ ] **SRP**: Classes possuem responsabilidade coesa e única razão para mudança.
- [ ] **OCP**: Novas extensões não exigem alterações em cascata em códigos legados consolidados.
- [ ] **LSP**: Implementações de interface e subclasses honram os contratos sem lançar exceções de rejeição.
- [ ] **ISP**: Interfaces são específicas, coesas e sem métodos desnecessários para os consumidores.
- [ ] **DIP**: Módulos de alto nível dependem de abstrações injetadas e não de instanciação direta (`new`).

### E. Segurança & Conformidade (OWASP)
- [ ] Nenhuma chave de API, credencial ou segredo gravado no código-fonte.
- [ ] Todas as queries a banco utilizam parâmetros nomeados ou PreparedStatements (Zero SQL Injection).
- [ ] Endpoints protegidos validam autorização no nível do objeto (Proteção contra BOLA / IDOR).
- [ ] Validação rigorosa de payload e tipos na borda da aplicação.

### F. Estratégia de Testes
- [ ] Testes automatizados adicionados cobrindo os novos cenários ou correções.
- [ ] Testes cobrem cenários negativos e casos de borda (valores nulos, vazios, limites).
- [ ] Asserções são precisas e validam estado real (sem testes assert-free).
- [ ] Testes são determinísticos e isolados (sem sleeps fixos ou dependência de ordem).

### G. Performance & Recursos
- [ ] Inexistência de consultas N+1 em loops sobre coleções ORM.
- [ ] Recursos gerenciados (streams, conexões) fechados via `try-with-resources`.
- [ ] Paginação obrigatória em consultas de listagem expostas em APIs.

---

## 2. Veredito Final
* Se **todos os itens** estiverem em conformidade: ✅ **PASS**
* Se houver itens de manutenção ou testes de borda pendentes (P2): ⚠️ **REVIEW**
* Se houver qualquer falha em Segurança, SDD divergente ou bug crítico (P0/P1): 🚫 **BLOCKED**
