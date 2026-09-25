# Skill: Java & Spring Boot Engineering

---

## 1. Purpose
A skill **java-spring** audita e orienta o desenvolvimento idiomático, robusto e performático no ecossistema Java (versões modernas 17/21+) e framework **Spring Boot** (Spring Data JPA, Spring Security, Spring Web, Spring Cloud), assegurando o uso correto do container IoC, gestão transacional e prevenção de armadilhas clássicas do ecossistema.

---

## 2. When to Use
* Durante o workflow `/audit`, `/review` ou `/sdd` em projetos Java e Spring Boot.
* Ao desenhar controladores REST, serviços `@Service`, repositórios `@Repository` e configurações de segurança.
* Ao auditar anotações transacionais (`@Transactional`), injeção de dependência e tratamento global de erros.

---

## 3. Inputs
* Arquivos `.java` e manifestos de dependência (`pom.xml` / `build.gradle`).
* Arquivos de configuração (`application.yml` / `application.properties`).
* Definições de entidades JPA, DTOs e endpoints Spring MVC / WebFlux.

---

## 4. Required Context
* [SKILLS/clean-code](../clean-code/SKILL.md) e [SKILLS/solid](../solid/SKILL.md).
* Padrões em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Injeção de Dependências**:
   * O projeto usa injeção por construtor com campos `final` (preferível e imutável) ou injeção por campo via `@Autowired` (desencorajada)?
2. **Auditoria Transacional (`@Transactional`)**:
   * Métodos chamados internamente dentro da mesma classe possuem `@Transactional` que é ignorado pelo proxy do Spring (*self-invocation trap*)?
   * Métodos `@Transactional` englobam chamadas HTTP externas lentas (segurando conexões de banco desnecessariamente)?
3. **Mapeamento JPA & Hibernate**:
   * Relacionamentos `@OneToMany` usam `FetchType.LAZY` por padrão ou incorrem no risco de `FetchType.EAGER`?
   * Entidades utilizam `@Data` do Lombok em relacionamentos bidirecionais (risco de `StackOverflowError` em `equals()` e `hashCode()`)?
4. **Tratamento de Exceções & Validação**:
   * Uso de `@RestControllerAdvice` com métodos `@ExceptionHandler` estruturados retornando RFC 7807 (`ProblemDetail`)?
   * Uso de Bean Validation (`@Valid`, `@NotNull`, `@Size`) em DTOs de entrada.
5. **Modernidade Java (17/21)**:
   * Uso de `record` para DTOs imutáveis, Pattern Matching para `instanceof`, Text Blocks e Virtual Threads quando aplicável.

---

## 6. Rules
* **R1 — Injeção por Construtor Obrigatória**: Proibido `@Autowired` em campos privados; utilizar construtores explícitos ou `@RequiredArgsConstructor`.
* **R2 — DTOs Desacoplados de Entidades**: Proibido retornar entidades `@Entity` do JPA diretamente no `@RestController` (evitar vazamento de dados e proxies Hibernate nulos).
* **R3 — Self-Invocation Cautela**: Anotações que dependem de proxies Spring (`@Transactional`, `@Async`, `@Cacheable`) não funcionam em chamadas de métodos privados ou internos da mesma instância.

---

## 7. Anti-Patterns
* **Field Injection**: Uso disseminado de `@Autowired private Service service;` dificultando testes unitários sem Spring context.
* **Lombok @Data on JPA Entities**: Quebra de contratos de coleções e recursão infinita em relacionamentos bidirecionais.
* **Open Session in View (OSIV) Habilitado em Produção**: Permite queries tardias durante a renderização da view, ocultando problemas de performance.

---

## 8. Output Format

```markdown
# Java & Spring Boot Audit: [Projeto]

## Conformidade de Ecossistema
* Versão Java: 17/21 (Conforme)
* Injeção de Dependência: Por construtor (Conforme)
* Gestão Transacional: Correta / Alerta de Self-Invocation

## Findings Específicos
* **[P1] Entidade JPA Exposta na API**:
  * **Arquivo**: `src/main/java/com/app/controller/UserController.java#L30`
  * **Problema**: Método retorna `UserEntity` diretamente em vez de `UserResponseDto`.
  * **Recomendação**: Mapear para Record DTO antes do retorno.
```

---

## 9. Examples
* **Caso**: O método chama internamente `this.processInternal()` anotado com `@Transactional(propagation = Propagation.REQUIRES_NEW)`.
* **Veredito**: `P1 - CRITICAL`.
* **Ação**: O proxy Spring é ignorado em chamadas locais; extrair `processInternal()` para um serviço colaborador injetado.
