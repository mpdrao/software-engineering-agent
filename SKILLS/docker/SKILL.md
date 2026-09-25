# Skill: Docker & Containerization Best Practices

---

## 1. Purpose
A skill **docker** audita e otimiza a criação de imagens de container, arquivos `Dockerfile` e orquestrações locais (`docker-compose.yml`), focando em segurança de execução, minimização do tamanho da imagem, eficiência de cache de camadas e resiliência operacional.

---

## 2. When to Use
* Durante o workflow `/audit` ou `/security` ao avaliar infraestrutura de empacotamento.
* Ao criar ou revisar Dockerfiles e compose files de novos serviços.
* Ao otimizar o tempo de build em pipelines CI/CD ou mitigar vulnerabilidades em imagens base.

---

## 3. Inputs
* Arquivos `Dockerfile`, `.dockerignore` e `docker-compose.yml`.
* Configurações de build e scripts de inicialização (`entrypoint.sh`).

---

## 4. Required Context
* [SKILLS/security](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/security/SKILL.md) (Menor privilégio em containers).
* Diretrizes em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Multi-Stage Builds**:
   * O Dockerfile separa o estágio de compilação (com SDKs pesados) do estágio de execução em produção (com imagem enxuta)?
2. **Segurança & Usuário Não-Root**:
   * O container executa como usuário `root` (UID 0) ou define um usuário dedicado sem privilégios (`USER appuser`)?
3. **Eficiência de Camadas & Cache**:
   * As instruções menos propensas a mudanças (instalação de dependências do SO, download de bibliotecas) estão posicionadas antes das instruções de código-fonte (`COPY src/`)?
   * Comandos `RUN apt-get update && apt-get install` removem os caches residuais na mesma camada para reduzir o tamanho?
4. **Higiene do Contexto (.dockerignore)**:
   * Existe um arquivo `.dockerignore` configurado para não enviar pastas `node_modules`, `.git`, arquivos `.env` ou temporários para o daemon do Docker?
5. **Configuração de Healthcheck & Sinais**:
   * O container possui instrução `HEALTHCHECK` determinística?
   * O processo principal recebe sinais de terminação (`SIGTERM`) adequadamente para fechamento gracioso (*graceful shutdown*)?

---

## 6. Rules
* **R1 — Proibição de Root em Produção**: Containers que executam código de aplicação em produção devem compulsoriamente rodar sob um usuário não-root.
* **R2 — Proibição de Tag :latest em Imagens Base**: Imagens base devem fixar tags semânticas ou digests imutáveis (ex.: `eclipse-temurin:21-jre-alpine` em vez de `openjdk:latest`).
* **R3 — .dockerignore Obrigatório**: Nenhum projeto containerizado deve existir sem `.dockerignore` contendo segredos locais e pastas de build.

---

## 7. Anti-Patterns
* **Single-Stage Fat Images**: Deixar compiladores, ferramentas de build (Maven, Gradle, npm) e código-fonte dentro da imagem final de produção.
* **Hardcoding Secrets in Dockerfile**: Passar tokens ou senhas via instruções `ENV` ou `ARG` que ficam gravados no histórico de camadas da imagem.
* **Ignoring SIGTERM**: Utilizar scripts de entrypoint que usam shell wrappers que não repassam sinais do sistema operacional para a aplicação.

---

## 8. Output Format

```markdown
# Docker Audit: [Dockerfile]

## Indicadores de Qualidade
* Multi-Stage Build: Sim / Não
* Usuário Não-Root: Configurado / Rodando como Root (P0)
* Tamanho Estimado: Enxuto (Alpine/Distroless) / Inflado

## Findings
* **[P0 - BLOCKER] Execução como Root em Produção**:
  * **Arquivo**: `Dockerfile#L15`
  * **Problema**: Inexistência da instrução `USER`. O container roda como root.
  * **Recomendação**:
    ```dockerfile
    RUN addgroup -S appgroup && adduser -S appuser -G appgroup
    USER appuser
    ```
```

---

## 9. Examples
* **Caso**: O desenvolvedor copiou `.env` para dentro da imagem Docker com credenciais de banco:
  `COPY .env /app/.env`
* **Veredito**: `P0 - BLOCKER`.
* **Ação**: Remover o `.env` do Dockerfile, adicioná-lo ao `.dockerignore` e injetar credenciais em runtime via orquestrador (Docker Compose, Kubernetes ou ECS).
