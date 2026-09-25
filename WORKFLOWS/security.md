# Workflow: /security

---

## 1. Objetivo
Executar auditoria estática especializada de segurança (SAST) em componentes de software, APIs e infraestrutura como código, identificando vulnerabilidades críticas baseadas no OWASP Top 10 e bloqueando riscos operacionais.

---

## 2. Skills Utilizadas
* [SKILLS/security](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/security/SKILL.md)
* [SKILLS/code-review](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/code-review/SKILL.md)

---

## 3. Arquivos Consultados
* Configurações de segurança (`SecurityConfig`, filtros de autenticação, JWT).
* Endpoints e controladores públicos e protegidos.
* Repositórios de dados e queries nativas.
* Variáveis de ambiente e manifestos de infraestrutura (`Dockerfile`, `docker-compose.yml`, `application.yml`).

---

## 4. Sequência de Análise
1. **Varredura de Hardcoded Secrets**: Identificar chaves de API, senhas, tokens ou certificados privados expostos no código.
2. **Varredura de Injeções**: Analisar todas as operações de banco de dados e execução de comandos de SO contra injeções.
3. **Auditoria de Autenticação & Autorização**:
   * Verificar se todos os endpoints possuem regras de autorização explícitas.
   * Checar proteção contra BOLA / IDOR na manipulação de chaves primárias.
4. **Auditoria de Configurações**: Checar políticas de CORS, headers de segurança (HSTS, CSP) e proteção CSRF.
5. **Auditoria de Dados Sensíveis**: Identificar logging indevido de senhas, cartões de crédito ou dados pessoais (LGPD/GDPR).

---

## 5. Formato da Saída
* Relatório especializado de segurança com mapeamento de CWE / OWASP.
* Classificação de severidade estrita (P0 para injeções e segredos expostos).
* Código de remediação imediato.

---

## 6. Condições de Sucesso
* Varredura exaustiva de credenciais e injeções.
* Qualquer vulnerabilidade crítica gera automaticamente veredito `BLOCKED`.
