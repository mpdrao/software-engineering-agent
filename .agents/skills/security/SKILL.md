---
name: security
description: >-
  Executa auditoria estática de segurança (SAST) orientada ao OWASP Top 10, sanitização de dados, controle de acessos e detecção de segredos expostos. Use esta skill quando o usuário digitar /security ou solicitar auditoria de segurança em código ou configurações.
---

# Skill: /security — Auditoria Estática de Segurança (SAST)

Inspeciona o código-fonte em busca de vulnerabilidades lógicas, falhas de autorização, injeções e vazamentos de credenciais.

---

## 1. Parâmetros de Entrada

Ao receber `/security [argumentos]`, extraia:
- `target`: Diretório, arquivo ou camada alvo (ex: controllers, endpoints, configs). Se omitido, assuma o projeto atual.
- `scope` *(opcional)*: `owasp` (padrão), `secrets`, `auth` ou `full`.

---

## 2. Vetores de Inspeção (OWASP Top 10 e Hardening)

1. **Injeção de Código e Dados:**
   - SQL Injection (concatenação em queries vs prepared statements).
   - Command Injection (chamadas a subprocessos com input de usuário).
   - Cross-Site Scripting (XSS) e renderização sem escape.
2. **Autenticação e Autorização:**
   - Broken Object Level Authorization (BOLA / IDOR): endpoints validam se o usuário autenticado é dono do recurso?
   - Validação de tokens JWT (algoritmo, expiração, assinatura).
3. **Gerenciamento de Segredos:**
   - Varredura de strings literais de chaves de API, senhas ou tokens privados no código.
4. **Configurações de Segurança e Cabeçalhos:**
   - Políticas de CORS, cookies com flags `HttpOnly` e `Secure`, Content-Security-Policy (CSP).
5. **Criptografia e Hashing:**
   - Uso de algoritmos obsoletos (MD5, SHA-1) para senhas vs algoritmos seguros (bcrypt, Argon2).

---

## 3. Saída Gerada

- Tabela de vulnerabilidades classificadas por severidade (P0 Crítico a P3 Baixo).
- Referência exata de arquivo e linha.
- Trecho de código prescritivo demonstrando a correção segura (Remediation).
