# Skill: DevOps, CI/CD & Observability

---

## 1. Purpose
A skill **devops** avalia a automação de compilação, testes contínuos, empacotamento, entrega (CI/CD), provisionamento de infraestrutura como código (IaC) e pilares de observabilidade operacional (logs estruturados, métricas e tracing distribuído).

---

## 2. When to Use
* Durante a etapa de DevOps/Observabilidade do workflow `/audit`.
* Ao criar ou revisar pipelines de integração contínua (GitHub Actions, GitLab CI, Jenkins).
* Ao configurar monitoramento, healthchecks ou políticas de log em produção.

---

## 3. Inputs
* Arquivos de pipeline (`.github/workflows/*.yml`, `.gitlab-ci.yml`).
* Arquivos de infraestrutura como código (Terraform, CloudFormation, Ansible).
* Configurações de observabilidade (Micrometer, OpenTelemetry, Logback, Prometheus).

---

## 4. Required Context
* [AGENT/system.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/system.md) (Observabilidade como princípio inegociável).
* Diretrizes em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Auditoria de Pipeline CI/CD**:
   * O pipeline executa compilação, linters, testes unitários e testes de integração de forma automatizada em todo commit ou PR?
   * Os artefatos gerados são imutáveis e versionados semanticamente?
2. **Auditoria de Observabilidade**:
   * **Logs**: Os logs são emitidos em formato estruturado (JSON)? Há ausência de prints brutos (`System.out.println` ou `console.log`)?
   * **Traces**: Há propagação de identificadores de correlação (`traceId`/`spanId`) entre serviços?
   * **Métricas**: A aplicação expõe endpoints de métricas (`/actuator/prometheus`, `/metrics`) e healthchecks determinísticos (`/health/live`, `/health/ready`)?
3. **Gerenciamento de Ambientes & Configurações (12-Factor App)**:
   * As configurações de ambiente são estritamente separadas do código via variáveis de ambiente?
   * As portas e dependências de serviços externos são parametrizáveis?

---

## 6. Rules
* **R1 — Proibição de Builds com Testes Ignorados**: O pipeline de CI nunca deve conter flags como `-DskipTests` ou `--ignore-test-failures` para mascarar erros.
* **R2 — Logs Estruturados Obrigatórios**: Todo log em ambiente corporativo deve ser estruturado com nível apropriado (DEBUG, INFO, WARN, ERROR).
* **R3 — Healthchecks Liveness e Readiness Separados**: Não misturar a verificação de que a aplicação está de pé (*liveness*) com a prontidão para receber tráfego (*readiness*).

---

## 7. Anti-Patterns
* **Console.log Driven Development**: Uso de logs não estruturados e poluídos para depuração em produção.
* **Snowflake Servers**: Servidores ou ambientes de produção configurados manualmente sem IaC reproduzível.
* **Secret Leak in CI Logs**: Impressão de variáveis de ambiente com tokens ou senhas nos logs do pipeline de build.

---

## 8. Output Format

```markdown
# DevOps & Observability Audit: [Projeto]

## Resumo Operacional
* CI/CD Pipeline: Ativo / Incompleto / Ausente
* Qualidade de Logs: Estruturado (JSON) / Texto Bruto
* Healthchecks: Conforme / Não Configurado

## Findings
* **[P2] Logs não estruturados**:
  * **Arquivo**: `src/main/java/com/app/controller/WebhookController.java#L25`
  * **Problema**: Uso de `System.out.println("Payload: " + body)` em vez de logger com máscara de dados sensíveis.
```

---

## 9. Examples
* **Caso**: O pipeline do GitHub Actions executa `mvn package -DskipTests=true` para agilizar o deploy.
* **Veredito**: `P1 - CRITICAL`.
* **Ação**: Restaurar a execução compulsória de testes e otimizar cache de dependências `.m2`.
