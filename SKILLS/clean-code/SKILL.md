# Skill: Clean Code & Maintainability

---

## 1. Purpose
A skill **clean-code** audita a legibilidade intrínseca, clareza semântica, nível de abstração e sustentabilidade do código-fonte, aplicando as melhores práticas da engenharia de software para garantir que o código seja lido e compreendido rapidamente por outros engenheiros com o menor esforço cognitivo.

---

## 2. When to Use
* Durante o workflow `/review`, `/refactor` ou `/audit`.
* Ao avaliar complexidade cognitiva de métodos e classes.
* Ao identificar code smells e oportunidades de simplificação.

---

## 3. Inputs
* Arquivos de código-fonte de qualquer linguagem suportada.
* Convenções de estilo do projeto (caso existam em `context.md`).

---

## 4. Required Context
* [AGENT/decision-making.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/decision-making.md) (Simplicidade acima de sofisticação).
* Padrões em `BRAIN/03-CODE-QUALITY/`.

---

## 5. Analysis Procedure
1. **Nomenclatura e Intenção Reveladora**:
   * As classes são substantivos claros?
   * Os métodos são verbos que expressam o efeito colateral ou retorno sem ambiguidades?
   * Foram evitadas abreviações enigmáticas (ex.: `mgr`, `proc`, `tmp`, `data1`)?
2. **Tamanho de Funções e Nível Único de Abstração (SLAP)**:
   * Cada método opera em um único nível conceitual?
   * Métodos com mais de 20-30 linhas contêm múltiplos passos que deveriam ser extraídos?
3. **Parâmetros e Assinaturas**:
   * O método recebe mais de 3 argumentos? (Sinal de agrupamento em objeto de parâmetro).
   * Existem parâmetros booleanos do tipo "flag" que forçam o método a fazer duas coisas distintas?
4. **Comentários vs. Código Autoexplicativo**:
   * O comentário está explicando o "como" porque o código é obscuro?
   * Comentários redundantes que apenas repetem o nome do método devem ser removidos.
5. **Expressividade de Controle de Fluxo**:
   * Uso adequado de *Early Return* / *Guard Clauses* para evitar blocos `if/else` profundamente aninhados.

---

## 6. Rules
* **R1 — Regra do Escoteiro**: Deixe o código mais limpo do que como o encontrou, mas sem extrapolar o escopo da tarefa atual.
* **R2 — Guard Clauses Primeiro**: Elimine `else` desnecessários quando uma condição de erro ou saída puder retornar imediatamente.
* **R3 — Não Minta no Nome**: Se o método chama `getUser()`, ele não deve salvar auditoria no banco ou enviar email silenciosamente (efeitos colaterais ocultos).

---

## 7. Anti-Patterns
* **Flag Argument**: `processOrder(Order order, boolean isVip)` gerando bifurcações dentro do método.
* **Arrow Code**: Estruturas de decisão profundamente indentadas em formato de flecha (`>`).
* **Dead Code**: Código comentado, funções não chamadas ou variáveis não utilizadas.

---

## 8. Output Format

```markdown
# Clean Code Analysis: [Arquivo]

## Smells Detectados
* **Deep Nesting (Nível 4)**: `OrderProcessor.java#L52` possui 4 loops e condicionais aninhados.
  * **Refatoração**: Aplicar Guard Clauses e extrair cálculo para método auxiliar puro.
* **Flag Argument**: `NotificationService.java#L12` recebe `boolean sendSms`.
  * **Refatoração**: Dividir em dois métodos intencionais: `sendEmailNotification()` e `sendSmsNotification()`.
```

---

## 9. Examples
* **Antes (Código Obscuro)**:
  ```java
  public void proc(List<Item> l) {
      for (Item i : l) {
          if (i.st == 1) {
              if (i.val > 100) {
                  // aplica taxa
                  i.val = i.val * 1.1;
              }
          }
      }
  }
  ```
* **Depois (Clean Code)**:
  ```java
  public void applyTaxToActiveHighValueItems(List<Item> items) {
      items.stream()
          .filter(Item::isActive)
          .filter(Item::isHighValue)
          .forEach(Item::applyTax);
  }
  ```
