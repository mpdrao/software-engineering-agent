# Manual Operacional de Workflows — SE-OS

Este documento é o guia definitivo de execução e parametrização dos **9 Workflows Operacionais** do **Software Engineering Operating System (SE-OS)** no Gemini CLI / Antigravity (`agy`).

---

## 1. Visão Geral dos Comandos

| Comando | Workflow | Objetivo Primário | Escopo Típico |
| :---: | :--- | :--- | :--- |
| **`/audit`** | [audit.md](audit.md) | Auditoria técnica exaustiva de 15 etapas | Repositório / Projeto completo |
| **`/sdd`** | [sdd.md](sdd.md) | Rastreabilidade Requisito $\rightarrow$ Código $\rightarrow$ Teste | Especificação + Implementação |
| **`/review`** | [review.md](review.md) | Revisão técnica de PR / diff antes do commit | Arquivos alterados / PR |
| **`/analyze`** | [analyze.md](analyze.md) | Investigação diagnóstica sob demanda | Arquivo, classe ou pacote |
| **`/architect`**| [architect.md](architect.md) | Modelagem arquitetural C4 e emissão de ADR | Sistema ou subsistema |
| **`/security`** | [security.md](security.md) | Auditoria estática de vulnerabilidades (SAST) | Endpoints, configs e rotas |
| **`/test`** | [testing.md](testing.md) | Diagnóstico da pirâmide e qualidade de asserções | Suítes de teste |
| **`/performance`**| [performance.md](performance.md)| Detecção de gargalos, $O(n^2)$ e N+1 queries | Loops, queries e algoritmos |
| **`/refactor`** | [refactor.md](refactor.md) | Refatoração guiada por testes prévios | Classes ou métodos com smells |

---

## 2. Especificação Detalhada por Workflow

---

### 1. `/audit` — Auditoria Técnica Completa
Executa a varredura exaustiva em **15 etapas sequenciais** cobrindo arquitetura, segurança, qualidade, banco de dados, testes e DevOps.

* **Regra Fundamental:** Estritamente **Read-Only** (nunca altera o código do projeto durante a análise).
* **Parâmetros:**
  * `target` *(Obrigatório)*: Caminho absoluto ou relativo da raiz do projeto a ser auditado.
  * `project_name` *(Opcional)*: Nome para identificação e registro em `PROJECTS/<nome>/`.
  * `persist_inbox` *(Padrão: `true`)*: Se ativado, gera automaticamente notas de aprendizado em `BRAIN/99-INBOX/` no Obsidian.
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /audit no projeto C:\Users\mario\OneDrive\Projetos\meu-sistema
  ```
  ```text
  Execute o workflow /audit na pasta atual registrando o contexto como "margemAI"
  ```
* **Saída Gerada:** Relatório executivo completo, veredito de Quality Gate (`PASS`, `REVIEW`, `BLOCKED`) e criação de notas de aprendizado em `BRAIN/99-INBOX/`.

---

### 2. `/sdd` — Validação de Especificação (Specification Driven Development)
Audita se o código e os testes estão em conformidade estrita com os requisitos de negócio e contratos de API documentados.

* **Parâmetros:**
  * `spec` *(Obrigatório)*: Caminho do arquivo de especificação (`SPEC-XXX.md`, `openapi.yaml` ou `REQ-XXX.md`).
  * `target` *(Obrigatório)*: Pacote, classe ou serviço que implementa a especificação.
  * `tests` *(Opcional)*: Classe ou diretório de testes que assevera o comportamento.
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /sdd validando a especificação SPEC-001.md contra a classe PricingService.java e PricingServiceTest.java
  ```
  ```text
  Execute o workflow /sdd validando o contrato openapi.yaml na rota /v1/products contra o ProductController e ProductService
  ```
* **Saída Gerada:** Matriz de rastreabilidade classificando cada critério como `CONFORME`, `PARCIALMENTE_CONFORME`, `DIVERGENTE` ou `NÃO_IMPLEMENTADO`.

---

### 3. `/review` — Revisão de Código / Pull Request
Realiza revisão técnica aprofundada de um conjunto de alterações, focando em regressões, complexidade ciclomática, legibilidade e testes.

* **Parâmetros:**
  * `target` *(Obrigatório)*: Arquivo, lista de arquivos ou diff recente a revisar.
  * `scope` *(Opcional)*: `diff` (apenas as linhas alteradas) ou `file` (o arquivo inteiro no seu contexto).
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /review nos arquivos alterados no último commit
  ```
  ```text
  Execute o workflow /review no arquivo UserService.java avaliando possíveis riscos antes do merge
  ```
* **Saída Gerada:** Veredito (`APPROVED` ou `CHANGES_REQUESTED`), matriz de findings com código de correção prescritivo.

---

### 4. `/analyze` — Investigação Técnica Sob Demanda
Analisa profundamente um módulo, componente ou bug complexo, identificando responsabilidades e pontos de falha.

* **Parâmetros:**
  * `target` *(Obrigatório)*: Arquivo, classe ou diretório alvo da investigação.
  * `focus` *(Opcional)*: `all` (padrão), `solid`, `clean-code` ou `architecture`.
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /analyze na classe OrderProcessor.java com foco em SOLID e complexidade
  ```
  ```text
  Execute o workflow /analyze no pacote com.app.billing para mapear suas dependências externas
  ```
* **Saída Gerada:** Diagnóstico estruturado com diagnóstico de limites, riscos e recomendações priorizadas.

---

### 5. `/architect` — Desenho de Arquitetura & Decisões (ADR)
Desenha ou avalia opções arquiteturais aplicando o filtro de 5 perguntas contra sobre-engenharia, gerando diagramas C4 e emitindo ADRs formais.

* **Parâmetros:**
  * `problem` *(Obrigatório)*: Descrição do desafio arquitetural ou decisão técnica necessária.
  * `alternatives` *(Opcional)*: Tecnologias ou abordagens em disputa (ex: Kafka vs RabbitMQ, SQL vs NoSQL).
  * `target_system` *(Opcional)*: Nome do sistema ou módulo afetado.
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /architect para decidir entre autenticação Stateful (Redis Sessions) vs Stateless (JWT com Cookies HttpOnly). Emita uma ADR.
  ```
  ```text
  Execute o workflow /architect modelando os limites de contexto do novo subsistema de Notificações com diagrama C4
  ```
* **Saída Gerada:** Documento de visão arquitetural (`TEMPLATES/architecture.md`) ou ADR estruturada (`TEMPLATES/adr.md`).

---

### 6. `/security` — Auditoria Estática de Segurança (SAST)
Varre o código contra o OWASP Top 10, credenciais expostas (*hardcoded secrets*), injeções e falhas de autorização (BOLA/IDOR).

* **Parâmetros:**
  * `target` *(Obrigatório)*: Arquivo, pasta de controladores, repositórios ou arquivo de configuração (`application.yml`, `.env`).
  * `vector` *(Opcional)*: `all`, `injection`, `secrets`, `bola-idor`, `headers-cors`.
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /security na pasta backend/src/main com foco em injeções e credenciais expostas
  ```
  ```text
  Execute o workflow /security no arquivo SecurityConfig.java avaliando políticas de CORS e headers HTTP
  ```
* **Saída Gerada:** Relatório de vulnerabilidades com código CWE/OWASP, classificação de severidade (P0-P3) e correção de código imediata.

---

### 7. `/test` — Diagnóstico de Testes Automatizados
Audita a qualidade da suíte de testes, proporção da pirâmide de testes, determinismo (*anti-flaky*) e qualidade das asserções.

* **Parâmetros:**
  * `target` *(Obrigatório)*: Diretório de testes (`src/test/...`) ou classe de teste específica.
  * `tested_component` *(Opcional)*: Classe de negócio correspondente para verificar cobertura semântica de casos de borda.
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /test na pasta backend/src/test avaliando a proporção da pirâmide e a qualidade das asserções
  ```
  ```text
  Execute o workflow /test na classe ProductServiceTest.java verificando se faltam cenários de valores nulos ou limites
  ```
* **Saída Gerada:** Diagnóstico de asserções fracas, detecção de *mock overdose*, testes dependentes de tempo e código AAA de testes ausentes.

---

### 8. `/performance` — Otimização e Profiling de Código
Identifica complexidade algorítmica ineficiente ($O(n^2)$), consultas N+1 em banco de dados, alocações excessivas de memória e vazamento de conexões.

* **Parâmetros:**
  * `target` *(Obrigatório)*: Método, loop, classe de serviço ou repositório sob suspeita de lentidão.
  * `expected_volume` *(Opcional)*: Quantidade de registros estimada em produção (ex: 50.000 itens/minuto).
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /performance no método ProductService.findAll investigando potenciais consultas N+1
  ```
  ```text
  Execute o workflow /performance no algoritmo de conciliação bancária avaliando complexidade assintótica
  ```
* **Saída Gerada:** Comparativo de complexidade algorítmica (Antes vs Depois) e código de refatoração em lote (*batching/hash lookup*).

---

### 9. `/refactor` — Refatoração Segura Guiada por Testes
Orienta ou executa a refatoração atômica de código legado mantendo estritamente o comportamento externo observável.

* **Parâmetros:**
  * `target` *(Obrigatório)*: Classe ou método a ser refatorado.
  * `safety_test` *(Obrigatório)*: Classe de testes automatizados que garante que o comportamento não quebre (*Safety Net*).
  * `goal` *(Obrigatório)*: Objetivo da refatoração (ex: eliminar duplicação, reduzir linhas de método, aplicar Guard Clauses).
* **Exemplos de Prompt:**
  ```text
  Execute o workflow /refactor no método calculatePricing da classe PricingService.java, utilizando PricingServiceTest.java como rede de segurança para aplicar Guard Clauses
  ```
* **Saída Gerada:** Plano de micropassos executados, validação da passagem dos testes e comparativo de código.

---

## 3. Matriz de Resumo de Parâmetros

```text
┌──────────────┬───────────────────────────────┬───────────────────────────────┐
│ Workflow     │ Parâmetro Principal           │ Parâmetro Secundário          │
├──────────────┼───────────────────────────────┼───────────────────────────────┤
│ /audit       │ target: caminho da raiz       │ project_name: nome no Brain   │
│ /sdd         │ spec: arquivo de requisitos   │ target: código implementado   │
│ /review      │ target: arquivo/diff/PR       │ scope: diff | file            │
│ /analyze     │ target: classe ou módulo      │ focus: solid | clean-code     │
│ /architect   │ problem: desafio técnico      │ alternatives: opções A vs B   │
│ /security    │ target: arquivo ou pasta      │ vector: owasp | secrets       │
│ /test        │ target: diretório de testes   │ tested_component: serviço     │
│ /performance │ target: método ou query       │ expected_volume: volume/RPS   │
│ /refactor    │ target: classe a refatorar    │ safety_test: suíte de teste   │
└──────────────┴───────────────────────────────┴───────────────────────────────┘
```
