# Skill: Code Review

---

## 1. Purpose
A skill **code-review** realiza revisões técnicas rigorosas em trechos de código, pull requests ou arquivos inteiros, com foco em corretude funcional, prevenção de regressões, legibilidade, concisão, manutenibilidade e conformidade com as diretrizes do projeto.

---

## 2. When to Use
* Durante o workflow `/review` ou etapas de PR inspection.
* Antes de submeter ou mesclar novos códigos.
* Para avaliar a qualidade de uma refatoração ou correção de bug.

---

## 3. Inputs
* Arquivos alterados (diff / patch) ou arquivo completo sob revisão.
* Contexto das classes dependentes ou interfaces implementadas.
* Requisito ou issue de origem que motivou a mudança.

---

## 4. Required Context
* [AGENT/behavior.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/behavior.md) (Abordagem de fatos vs. hipóteses, preservação de contexto).
* Diretrizes em `BRAIN/03-CODE-QUALITY/`.
* Matriz de severidade em `QUALITY-GATES/severity.md`.

---

## 5. Analysis Procedure
1. **Verificação de Corretude Lógica**:
   * O código atende à intenção declarada sem introduzir off-by-one errors, NullPointerExceptions, concorrência desprotegida ou vazamento de recursos?
2. **Avaliação de Complexidade Ciclomática**:
   * O fluxo possui aninhamento excessivo (mais de 2-3 níveis de if/for/switch)?
   * O método pode ser decomposto em funções puras ou expressivas?
3. **Tratamento de Exceções & Resiliência**:
   * Há blocos catch vazios (`catch (Exception e) {}`) engolindo erros críticos?
   * Exceções genéricas estão mascarando falhas operacionais?
4. **Legibilidade & Expressividade**:
   * Nomes de variáveis e métodos refletem a linguagem ubíqua do domínio?
   * Existem "números mágicos" ou strings soltas sem constantes nomeadas?
5. **Preservação de Integridade**:
   * Comentários essenciais foram mantidos?
   * Há código morto ou importações desnecessárias deixadas para trás?

---

## 6. Rules
* **R1 — Proibição de Nitpicks Cosméticos Sem Impacto**: Comentários puramente subjetivos sobre preferências pessoais de estilo devem ser rotulados como `P3 - IMPROVEMENT` e não podem bloquear o merge.
* **R2 — Justificativa com Exemplo**: Todo apontamento crítico (P0-P2) deve apresentar o código sugerido com a correção.
* **R3 — Respeito ao Escopo do PR**: Não exigir refatorações massivas em código legado que não foi tocado no PR atual.

---

## 7. Anti-Patterns
* **The Rubber Stamp**: Aprovar código superficialmente sem examinar cenários de borda.
* **Swallowed Exceptions**: Tratar exceções apenas logando ou ignorando, deixando o sistema em estado inconsistente.
* **Premature Optimization**: Trocar código legível por código ilegível sob a justificativa de "performance" sem profiling comprovado.

---

## 8. Output Format

```markdown
# Code Review: [Componente / PR]

## Verdict
* Status: `PASS` | `CHANGES_REQUESTED`
* Severidade Máxima: `P1 - CRITICAL`

## Key Findings

### [P1] Null Pointer Risk em Chamada Encadeada
* **Arquivo**: `src/main/java/com/app/service/UserService.java#L44`
* **Problema**: `user.getProfile().getAddress().getZipCode()` sem verificação de nulos.
* **Sugestão**:
  ```java
  Optional.ofNullable(user)
      .map(User::getProfile)
      .map(Profile::getAddress)
      .map(Address::getZipCode)
      .orElse("DEFAULT_ZIP");
  ```
```

---

## 9. Examples
* **Caso**: O desenvolvedor alterou a assinatura de um método público usado em múltiplos módulos sem atualizar os chamadores.
* **Veredito**: `P0 - BLOCKER`.
* **Ação**: Quebra de contrato de API detectada. Exige compatibilidade retroativa ou migração coordenada.
