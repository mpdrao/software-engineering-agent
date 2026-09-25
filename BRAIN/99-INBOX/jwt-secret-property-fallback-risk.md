---
type: learning
status: candidate
domain: security
id: LRN-001
title: "Risco de Fallback Estático para Segredos de Assinatura JWT em application.properties"
tags: [security, jwt, authentication, spring-boot, owasp, candidate]
created: 2026-09-25
updated: 2026-09-25
source: "Auditoria margemAI"
confidence: high
---

# LRN-001: Risco de Fallback Estático para Segredos JWT em application.properties

## 1. Problema Observado
Durante a auditoria do projeto **Margem.AI**, foi identificado que a chave secreta de assinatura e validação dos tokens JWT foi configurada com um valor padrão estático no arquivo `application.properties`:

```properties
jwt.secret=${JWT_SECRET:dev-only-404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970}
```

---

## 2. Investigação & Diagnóstico
* **Mecanismo de Falha Silenciosa**: O operador `:` do Spring Framework define um valor de contingência (*default/fallback*). Se a variável de ambiente `JWT_SECRET` for esquecida na esteira de CI/CD ou nas configurações do container de homologação/produção, a aplicação não falhará na inicialização (*fail-fast*). Em vez disso, ela inicializará utilizando a chave pública conhecida que consta no repositório Git.
* **Causa Raiz**: Conveniência de desenvolvimento local sobreposta a regras estritas de segurança em produção.

---

## 3. Impacto de Segurança (OWASP)
* **Quebra de Autenticação (Broken Authentication)**: Qualquer pessoa com acesso ao repositório público ou privado pode gerar tokens JWT válidos para qualquer usuário (`userId`, roles, tenants), burlar a autenticação e assumir controle de contas.

---

## 4. Solução Canônica & Refatoração

### Abordagem A: Exigir a variável sem valor padrão (Fail-Fast)
No `application.properties`:
```properties
# A aplicação falhará imediatamente ao subir se JWT_SECRET não estiver definida
jwt.secret=${JWT_SECRET}
```

### Abordagem B: Validação Condicional no `@PostConstruct`
Se o fallback for tolerado exclusivamente para desenvolvimento local (`application-local.properties`):
```java
@Component
public class JwtSecurityValidator {

    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${spring.profiles.active:default}")
    private String activeProfile;

    @PostConstruct
    public void validateKey() {
        if (!"local".equals(activeProfile) && !"test".equals(activeProfile)) {
            if (jwtSecret.contains("dev-only") || jwtSecret.length() < 64) {
                throw new IllegalStateException("FATAL: JWT_SECRET de produção inválido ou utilizando chave padrão insegura!");
            }
        }
    }
}
```

---

## 5. Como Prevenir a Recorrência
1. **Regra de Portão (Quality Gate)**: Classificar qualquer chave simétrica com valor padrão em arquivos rastreados no Git como **`P1 - CRITICAL`**.
2. **Scanner de Secrets**: Adicionar `trufflehog` ou `gitleaks` no pipeline do GitHub Actions para barrar commits contendo segredos óbvios.

---

## 6. Rastreabilidade & Links
* Projeto de Origem: `[[PROJECTS/margemAI/context]]`
* Relatório: `[[PROJECTS/margemAI/audit-report-2026-09-25]]`
* Princípio: `[[00-CORE/engineering-principles]]`
