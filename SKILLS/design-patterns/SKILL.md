# Skill: Design Patterns & Idiomatic Architecture

---

## 1. Purpose
A skill **design-patterns** orienta a seleção, implementação e auditoria de padrões de projeto (GoF e corporativos), assegurando que os padrões sejam aplicados de forma idiomática para solucionar problemas reais de design e desacoplamento, enquanto combate vigorosamente o uso desnecessário de padrões como sobre-engenharia (*patternitis*).

---

## 2. When to Use
* Durante o workflow `/architect`, `/review` ou `/refactor`.
* Ao avaliar se uma classe ou módulo deve ser decomposto utilizando um padrão estrutural ou comportamental.
* Ao identificar duplicações lógicas que podem ser abstraídas através de polimorfismo limpo.

---

## 3. Inputs
* Estrutura de classes, diagramas de tipos e código-fonte sob avaliação.
* Requisitos de extensibilidade e variação de comportamento.

---

## 4. Required Context
* [AGENT/decision-making.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/decision-making.md) (Regras anti-overengineering e filtro de 5 perguntas).
* Modelos em [TEMPLATES/pattern.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/pattern.md) e [TEMPLATES/anti-pattern.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/anti-pattern.md).
* Conhecimento em `BRAIN/08-PATTERNS/`.

---

## 5. Analysis Procedure
1. **Identificação da Força de Design**:
   * O problema exige criação desacoplada de objetos (Factory, Builder)?
   * O problema exige composição estrutural flexível (Adapter, Decorator, Facade)?
   * O problema exige variação de algoritmos ou desacoplamento de remetente/destinatário (Strategy, Observer, Command)?
2. **Avaliação Pragmática**:
   * A linguagem já possui suporte nativo de primeira classe que dispensa o padrão clássico (ex.: Funções de ordem superior / Lambdas substituindo Strategy; Records/Data Classes substituindo Builders triviais)?
3. **Auditoria de Anti-Patterns**:
   * A aplicação sofre de Singleton Abuser (usar Singleton como variável global disfarçada)?
   * Há proliferação de classes abstratas com apenas uma subclasse (Abstração Prematura)?
4. **Verificação de Coesão**:
   * O padrão adotado facilitou a escrita de testes unitários ou introduziu camadas impeditivas de indireção?

---

## 6. Rules
* **R1 — Preferir Funções Puras a Hierarquias Rígidas**: Se um padrão comportamental puder ser representado por uma função de primeira classe ou lambda, prefira a abordagem funcional.
* **R2 — Builder Apenas para Objetos Complexos**: Não crie Builders para classes com 2 ou 3 atributos imutáveis onde um construtor ou factory method direto seja legível.
* **R3 — Proibição de Patternitis**: A aplicação de um padrão deve sempre demonstrar redução de complexidade ciclomática ou aumento real de testabilidade.

---

## 7. Anti-Patterns
* **Patternitis / Golden Hammer**: Tentar encaixar todos os padrões do livro GoF em um sistema simples de CRUD.
* **Singleton as Global State**: Compartilhamento de estado mutável via instâncias estáticas, inviabilizando paralelismo de testes.
* **Leaky Facade**: Uma fachada que expõe os tipos internos do subsistema complexo, anulando o isolamento.

---

## 8. Output Format

```markdown
# Design Pattern Evaluation: [Módulo]

## Padrões Identificados
* **Strategy**: `DiscountStrategy.java` aplicado com sucesso para regras tarifárias variáveis.
* **Builder Desnecessário**: `UserDto.java` com 3 campos implementando Builder de 80 linhas.

## Recomendações
* Simplificar `UserDto` utilizando `record UserDto(String id, String name, String email)`.
```

---

## 9. Examples
* **Caso**: O desenvolvedor criou 8 classes para implementar um Abstract Factory em um projeto que possui apenas 1 tipo de persistência e nunca terá outro.
* **Veredito**: `P2 - IMPORTANT (Overengineering)`.
* **Ação**: Eliminar as fábricas abstratas e instanciar o serviço diretamente via injeção de dependência do framework.
