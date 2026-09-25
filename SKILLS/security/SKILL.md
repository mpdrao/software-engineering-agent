# Skill: Security Review & Vulnerability Analysis

---

## 1. Purpose
A skill **security** realiza auditoria de segurança estática (SAST) em códigos-fonte, configurações de infraestrutura e dependências, orientando-se pelo **OWASP Top 10**, práticas de criptografia robusta, sanitização de dados, controle de acesso e proteção contra vazamento de credenciais.

---

## 2. When to Use
* Durante o workflow `/security` ou na etapa de segurança do `/audit`.
* Ao criar ou revisar endpoints de API públicos ou autenticados.
* Ao manipular autenticação, geração de tokens, senhas ou dados sensíveis (LGPD/GDPR/PII).
* Ao introduzir novas dependências de terceiros.

---

## 3. Inputs
* Código-fonte de controladores, filtros de segurança, serviços e repositórios.
* Arquivos de configuração de autenticação (Spring Security, middlewares JWT, CORS, etc.).
* Manifestos de dependências (`pom.xml`, `package.json`, `requirements.txt`).
* Arquivos de ambiente e propriedades (`application.yml`, `.env.example`, Dockerfiles).

---

## 4. Required Context
* Matriz de severidade em `QUALITY-GATES/severity.md` (Problemas de segurança críticos geram bloqueio imediato `P0`).
* Diretrizes em `BRAIN/04-SECURITY/`.

---

## 5. Analysis Procedure

A análise cobre os principais vetores de vulnerabilidade:

1. **Injeção (SQL, NoSQL, Command, LDAP)**:
   * Existem concatenações diretas de strings em queries SQL ou comandos de sistema operacional?
   * O código utiliza *PreparedStatements*, parâmetros nomeados ou ORMs de forma segura?
2. **Broken Authentication & Session Management**:
   * Há senhas ou tokens gravados em texto claro (*hardcoded secrets*)?
   * O algoritmo de hash de senhas é seguro (BCrypt, Argon2, PBKDF2 com salt)?
   * O tempo de expiração do JWT é razoável e a assinatura é rigorosamente validada?
3. **Broken Object Level Authorization (BOLA / IDOR)**:
   * O sistema permite acessar ou alterar recursos de outro usuário simplesmente alterando o ID na URL (`/orders/123`), sem validar se o recurso pertence ao usuário autenticado?
4. **Security Misconfiguration & CORS**:
   * A política de CORS é excessivamente permissiva (`Access-Control-Allow-Origin: *` com credenciais)?
   * O modo de debug ou stack traces detalhados estão ativos para ambiente de produção?
5. **Cross-Site Scripting (XSS) & CSRF**:
   * Dados recebidos do usuário são sanitizados antes de renderizados no DOM ou retornados em HTML?
   * Endpoints de mutação de estado (POST/PUT/DELETE) via cookies possuem proteção CSRF ativa?
6. **Vulnerabilidade em Dependências**:
   * Existem pacotes conhecidamente vulneráveis (CVEs reportados)?

---

## 6. Rules
* **R1 — Regra de Ouro: P0 para Injeção e Hardcoded Secrets**: Qualquer injeção direta de SQL/Comando ou chave de API em texto puro no repositório é classificada como `P0 - BLOCKER`.
* **R2 — Validação na Borda**: Toda entrada de dados externa deve ser tratada como hostil até passar por validação e sanitização estrita de schema.
* **R3 — Menor Privilégio**: Conexões de banco, tokens de API e roles de usuários devem ter apenas as permissões mínimas indispensáveis para sua função.

---

## 7. Anti-Patterns
* **Security by Obscurity**: Tentar ocultar um endpoint sem implementar checagem de autorização real no backend.
* **Rolling Your Own Crypto**: Implementar algoritmos próprios de criptografia ou hashing em vez de utilizar bibliotecas de padrão industrial consagradas.
* **Blind Deserialization**: Desserializar dados não confiáveis diretamente sem validação de tipos ou restrições de classe.

---

## 8. Output Format

```markdown
# Security Audit Report: [Alvo]

## Executive Summary
* **Veredito de Segurança**: `BLOCKED` | `REVIEW` | `PASS`
* **Vulnerabilidades P0**: 1
* **Vulnerabilidades P1**: 0

## Findings Detalhados

### [P0 - BLOCKER] SQL Injection Vulnerability
* **CWE**: CWE-89
* **Localização**: `src/main/java/com/app/repository/CustomReportRepo.java#L38`
* **Evidência**:
  ```java
  String query = "SELECT * FROM reports WHERE user_id = '" + userId + "'";
  return entityManager.createNativeQuery(query).getResultList();
  ```
* **Impacto**: Extração completa de dados confidenciais por usuários não autenticados.
* **Remediação Prescritiva**:
  ```java
  String query = "SELECT * FROM reports WHERE user_id = :userId";
  return entityManager.createNativeQuery(query)
      .setParameter("userId", userId)
      .getResultList();
  ```
```

---

## 9. Examples
* **Caso**: O desenvolvedor colocou a chave da AWS no arquivo `application.properties`:
  `aws.secret.key=AKIAIOSFODNN7EXAMPLE`
* **Veredito**: `P0 - BLOCKER`.
* **Ação**: Revogação imediata da credencial na AWS, remoção do histórico git via BFG/git-filter-repo e uso de variáveis de ambiente seguras (`AWS_SECRET_KEY`).
