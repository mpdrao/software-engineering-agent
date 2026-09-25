# Quality Gates — Matriz de Severidade

Este documento define os critérios formais para classificação de severidade de qualquer finding ou anomalia técnica identificada pelo agente durante revisões, auditorias ou análises.

---

## 1. Níveis de Severidade

| Nível | Rótulo | Descrição Geral | SLA de Resolução | Ação no Gate |
| :---: | :--- | :--- | :--- | :---: |
| **P0** | **BLOCKER** | Falha crítica com impacto direto em segurança, integridade de dados ou disponibilidade sistêmica imediata. | Imediato (pré-merge / pré-deploy) | **BLOCKED** |
| **P1** | **CRITICAL** | Desvio de especificação funcional (SDD), quebra de integridade de negócio, falha funcional ou regressão. | Curto Prazo (mesma sprint/PR) | **BLOCKED** |
| **P2** | **IMPORTANT** | Violações arquiteturais, degradação de manutenibilidade, code smells graves (SOLID) ou testes de borda ausentes. | Médio Prazo (revisão humana/backlog) | **REVIEW** |
| **P3** | **IMPROVEMENT**| Melhoria cosmética, sugestão de refatoração menor, padronização de nomenclatura ou nitpick sem risco. | Baixo Prazo / Opcional | **PASS** |

---

## 2. Critérios Objetivos de Enquadramento

### P0 — BLOCKER
Uma ocorrência é compulsoriamente **P0** quando apresentar:
* **Credenciais ou Segredos Expostos**: Tokens de API, chaves privadas, senhas de banco ou certificados no código-fonte.
* **Vulnerabilidade Explorável**: SQL Injection, Command Injection, desserialização insegura ou RCE (Remote Code Execution).
* **Perda ou Corrupção de Dados**: Queries destrutivas sem cláusula WHERE, ausência de controle transacional em operações financeiras.
* **Quebra Catastrófica de Contrato**: Remoção ou alteração de assinatura de API pública sem versionamento retrocompatível.
* **Deadlock / Travamento de Recursos**: Bloqueio concorrente determinístico ou pool de conexões exaurido sem liberação.

### P1 — CRITICAL
Uma ocorrência é classificada como **P1** quando apresentar:
* **Divergência de Especificação (SDD)**: O sistema calcula ou processa regra de negócio de forma diferente do especificado em `SPEC-XXX`.
* **Requisito Obrigatório Não Implementado**: Funcionalidade prometida na documentação de aceite completamente ausente no código.
* **Vazamento de Recursos (Memory / FD Leak)**: Streams de arquivo, sockets ou conexões HTTP abertos sem fechamento garantido.
* **Falha de Autorização (BOLA / IDOR)**: Ausência de verificação se o usuário logado tem permissão para acessar o recurso solicitado.
* **Testes Automatizados Quebrados**: Suíte de testes pré-existente falhando no branch.

### P2 — IMPORTANT
Uma ocorrência é classificada como **P2** quando apresentar:
* **Violação Grave de SOLID**: God Class (> 500 linhas com múltiplas responsabilidades), violação evidente de LSP ou dependência direta de implementações instáveis (DIP).
* **Anti-Padrão N+1 Queries**: Consultas executadas dentro de loops em relacionamentos ORM.
* **Ausência de Testes para Casos de Borda**: Métodos críticos sem testes cobrindo valores nulos, coleções vazias ou limites de valor.
* **Complexidade Ciclomática Excessiva**: Métodos com profundidade de aninhamento excessiva (> 4 níveis) ou mais de 50 linhas.
* **Tratamento Genérico / Supressão de Erros**: Blocos `catch (Exception e)` que apenas logam mensagem genérica sem relançar ou tratar.

### P3 — IMPROVEMENT
Uma ocorrência é classificada como **P3** quando apresentar:
* **Nomenclatura Subótima**: Variáveis com nomes curtos ou abreviados que poderiam ser mais expressivos.
* **Código Duplicado Menor**: Pequenas repetições de lógica utilitária (2-3 linhas) que poderiam ser unificadas.
* **Oportunidade Idiomática**: Substituição de loops tradicionais por Streams / Lambdas ou uso de operadores modernos da linguagem.
* **Comentários Redundantes**: Comentários óbvios que apenas repetem o que o método já declara.
