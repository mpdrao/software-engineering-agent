# Skill: SOLID Principles Audit

---

## 1. Purpose
A skill **solid** audita o design orientado a objetos avaliando a aplicação pragmática dos cinco princípios SOLID (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation e Dependency Inversion). Seu objetivo é combater a rigidez, fragilidade e imobilidade do código sem incorrer em sobre-engenharia de abstrações artificiais.

---

## 2. When to Use
* Durante o workflow `/review`, `/refactor` ou `/audit`.
* Ao avaliar classes que acumulam responsabilidades excessivas ou são difíceis de testar.
* Ao desenhar novas interfaces ou hierarquias de herança.

---

## 3. Inputs
* Código-fonte das classes de domínio, serviços, interfaces e repositórios.
* Diagrama ou estrutura de classes associadas.

---

## 4. Required Context
* [AGENT/decision-making.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/decision-making.md) (Evitar criação indiscriminada de interfaces desnecessárias).
* Diretrizes em `BRAIN/03-CODE-QUALITY/`.

---

## 5. Analysis Procedure

Para cada classe ou módulo sob auditoria:

1. **SRP (Single Responsibility Principle)**:
   * A classe possui mais de uma razão para mudar (ex.: lógica de cálculo de taxa + formatação de JSON + persistência em banco)?
   * Identificar o "e" no propósito: se a classe calcula impostos *e* envia emails, há violação de SRP.
2. **OCP (Open/Closed Principle)**:
   * Para adicionar uma nova regra ou variação de comportamento, é necessário alterar o código existente com novos blocos `switch` ou `if/else`?
   * A extensão é viável por polimorfismo, composição ou injeção de estratégias?
3. **LSP (Liskov Substitution Principle)**:
   * Subclasses ou implementações de interface lançam `UnsupportedOperationException` para métodos herdados?
   * Métodos sobrescritos alteram as pré-condições (tornando-as mais rígidas) ou pós-condições (enfraquecendo garantias)?
4. **ISP (Interface Segregation Principle)**:
   * Clientes são forçados a depender de interfaces infladas (*fat interfaces*) com métodos que não utilizam?
   * As interfaces são pequenas, coesas e orientadas ao cliente?
5. **DIP (Dependency Inversion Principle)**:
   * Módulos de alto nível importam e instanciam diretamente classes concretas de baixo nível (`new HttpClient()`, `new MySQLRepository()`)?
   * A dependência aponta para abstrações/interfaces injetadas?

---

## 6. Rules
* **R1 — Não Criar Interfaces Unilaterais Vazia**: Criar uma interface `IFoo` para a única classe `Foo` sem nenhuma variação de implementação ou benefício de teste é abstração prematura.
* **R2 — Cuidado com Falso SRP**: Fragmentar uma classe coesa de 40 linhas em 8 classes de 5 linhas prejudica a compreensão global do fluxo.
* **R3 — Respeito ao Contrato (LSP)**: Uma subclasse nunca deve quebrar o comportamento prometido pela superclasse.

---

## 7. Anti-Patterns
* **God Class / Blob**: Uma classe que concentra todas as decisões operacionais do subsistema.
* **Refused Bequest**: Subclasses que rejeitam métodos herdados lançando exceções ou deixando métodos vazios.
* **Hardcoded Dependencies**: Instanciação direta com `new` impedindo testes com dublês/mocks.

---

## 8. Output Format

```markdown
# SOLID Audit: [Classe / Módulo]

| Princípio | Status | Evidência / Arquivo | Impacto & Recomendação |
| :--- | :---: | :--- | :--- |
| **SRP** | VIOLADO | `ReportService.java#L20` | Mistura geração de PDF com chamadas SQL diretas. Extrair repositório e renderizador. |
| **OCP** | CONFORME | `DiscountPolicy.java` | Estrutura utiliza estratégias polimórficas. |
| **LSP** | CONFORME | Sem quebras de contrato | - |
| **ISP** | ATENÇÃO | `CrudRepository.java` | Clientes de leitura forçados a implementar métodos de escrita. Segregar `ReadOnlyRepository`. |
| **DIP** | VIOLADO | `PaymentProcessor.java#L15` | Instancia diretamente `new CieloClient()`. Injetar via construtor como abstração. |
```

---

## 9. Examples
* **Caso de Violação de LSP**:
  ```java
  public class ReadOnlyUserList implements List<User> {
      @Override
      public boolean add(User u) {
          throw new UnsupportedOperationException("Lista somente leitura!");
      }
  }
  ```
* **Diagnóstico**: Violação evidente de LSP. Um chamador que espera `List<User>` terá exceção inesperada em tempo de execução. Solução: não herdar de `List`, mas usar uma interface não mutável ou encapsular a coleção.
