---
name: audit
description: >-
  Executa auditoria técnica rigorosa de software em 15 etapas sequenciais com determinação de Quality Gate (PASS, REVIEW, BLOCKED). Use esta skill quando o usuário digitar /audit ou solicitar auditoria técnica completa de um projeto ou repositório.
---

# Skill: /audit — Auditoria Técnica Completa

Executa a varredura exaustiva de um repositório em 15 etapas sequenciais, cobrindo conformidade arquitetural, segurança, qualidade de código, testabilidade, banco de dados e DevOps.

> [!IMPORTANT]
> **Modo Read-Only**: O comando `/audit` nunca altera arquivos de código do projeto auditado sem consentimento prévio e explícito do usuário.

---

## 1. Parâmetros de Entrada

Ao receber o comando `/audit [argumentos]`, extraia:
- `target`: Caminho do projeto a ser auditado. Se não for especificado, assuma o diretório do workspace atual.
- `project_name` *(opcional)*: Nome identificador do sistema (ex: `margemAI`).
- `persist_inbox` *(padrão: `true`)*: Gravação de hipóteses e aprendizados em `BRAIN/99-INBOX/`.

---

## 2. Validação de Segurança Pré-Execução

1. Verifique se o caminho em `target` existe no sistema de arquivos.
2. Certifique-se de que o caminho não tenta navegar para áreas protegidas do sistema operacional (ex: `C:\Windows`, `/etc`, `~/.ssh/`).
3. Opere estritamente como leitura durante toda a análise.

---

## 3. Protocolo de Execução (15 Etapas Sequenciais)

Execute a inspeção ordenada, coletando evidências concretas:

1. **Project Discovery**: Identificar linguagem, versão, framework, build tool (`pom.xml`, `package.json`, etc.) e ponto de entrada.
2. **Specification Discovery**: Localizar `README`, contratos OpenAPI, documentação de negócio ou `SPEC-XXX`.
3. **Architecture Analysis**: Mapear estilo arquitetural (Hexagonal, Clean, Camadas), fronteiras entre módulos e acoplamento.
4. **Dependency Analysis**: Verificar versões desatualizadas, bibliotecas obsoletas ou sobreposição de dependências.
5. **Code Quality**: Inspecionar complexidade ciclomática, nomenclatura de símbolos, SLAP e Guard Clauses.
6. **SOLID Audit**: Avaliar SRP, OCP, LSP, ISP e DIP nas classes centrais de domínio e serviço.
7. **Design Patterns**: Diagnosticar aderência de padrões utilizados e identificar "Patternitis" / abstrações prematuras.
8. **Security Audit**: Inspecionar OWASP Top 10 (SQL Injection, XSS, sanitização, CORS, Auth, segredos hardcoded).
9. **Testing Audit**: Inspecionar pirâmide de testes, cobertura semântica de asserções e ausência de testes tautológicos.
10. **Database Analysis**: Inspecionar modelagem de dados, índices, mapeamentos ORM e problemas de N+1 queries.
11. **Performance Analysis**: Inspecionar algoritmos $O(n^2)$, loops aninhados com I/O síncrono e vazamento de memória.
12. **Observability**: Avaliar estruturação de logs, métricas e tracing distribuído.
13. **DevOps & Infra**: Inspecionar `Dockerfile` (multi-stage, non-root), CI/CD workflows e variáveis de ambiente.
14. **Technical Debt**: Consolidar catálogo priorizado de dívidas técnicas com estimativa de impacto.
15. **Quality Gate Verdict**: Aplicar a matriz de severidade matemática (P0 a P3).

---

## 4. Quality Gate e Saída

Classifique os achados:
- **P0 (Blocker)**: Falhas críticas de segurança, dados ou integridade.
- **P1 (Critical)**: Regressões funcionais graves ou N+1 queries em fluxos críticos.
- **P2 (Major)**: Violações moderadas de arquitetura ou débitos de manutenibilidade.
- **P3 (Minor)**: Melhorias cosméticas ou de documentação.

**Fórmula do Veredito:**
- $\text{count}(P0) > 0 \lor \text{count}(P1) > 0 \implies$ **`BLOCKED`**
- $\text{count}(P0) = 0 \land \text{count}(P1) = 0 \land \text{count}(P2) > 0 \implies$ **`REVIEW`**
- $\text{count}(P0) = 0 \land \text{count}(P1) = 0 \land \text{count}(P2) = 0 \implies$ **`PASS`**

Emita o relatório final contendo:
- Resumo Executivo e Tabela de Scorecard
- Matriz de Severidade e Veredito do Quality Gate
- Top 3 Riscos Imediatos com Código Prescritivo de Correção
