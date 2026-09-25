# Skill: Architecture Analysis

---

## 1. Purpose
A skill **architecture** avalia a integridade estrutural de sistemas de software, focando em limites de contexto (Bounded Contexts), coesão modular, acoplamento entre camadas, aderência a estilos arquiteturais (Clean/Hexagonal/Modular Monolith), dependências circulares e conformidade com ADRs aprovadas.

---

## 2. When to Use
* Durante o workflow `/architect` ou `/audit`.
* Ao avaliar alterações estruturais (criação de novos pacotes, serviços ou integrações).
* Para identificar violações de isolamento de camadas (ex.: vazamento de entidades de banco no frontend ou na camada de apresentação).
* Ao propor ou revisar Architecture Decision Records (`ADR`).

---

## 3. Inputs
* Estrutura de diretórios e árvore de pacotes do projeto.
* Arquivos de configuração de dependências (`pom.xml`, `package.json`, `build.gradle`, etc.).
* Arquivos de arquitetura e ADRs (`PROJECTS/<projeto>/architecture/`, `PROJECTS/<projeto>/decisions/`).
* Código-fonte dos limites de módulos (interfaces de serviço, adapters, controllers).

---

## 4. Required Context
* [AGENT/decision-making.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/decision-making.md) (Regras anti-overengineering e trade-offs).
* [TEMPLATES/architecture.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/architecture.md) e [TEMPLATES/adr.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/adr.md).
* Conhecimento persistido em `BRAIN/02-ARCHITECTURE/`.

---

## 5. Analysis Procedure
1. **Mapeamento de Camadas & Limites**: Identificar as camadas existentes (ex.: Domínio $\leftarrow$ Aplicação $\leftarrow$ Infraestrutura/Apresentação).
2. **Auditoria de Direção de Dependência**:
   * O domínio importa bibliotecas de infraestrutura (Spring, Hibernate, AWS SDK)? Se sim, flag de violação de regra de dependência.
   * Existem dependências cíclicas entre módulos (Módulo A $\rightarrow$ Módulo B $\rightarrow$ Módulo A)?
3. **Avaliação de Coesão e Acoplamento**:
   * O sistema apresenta forte acoplamento temporal (chamadas RPC encadeadas com risco de timeout em cascata)?
   * As entidades e agregados mantêm limites transacionais claros?
4. **Conformidade com ADRs**:
   * Verificar se as decisões históricas (`ADR-XXX`) estão sendo respeitadas ou silenciosamente quebradas.
5. **Verificação de Overengineering**:
   * O projeto adota microservices sem volume ou equipes que o justifiquem?
   * Há excesso de camadas vazias que apenas repassam chamadas sem valor agregado?

---

## 6. Rules
* **R1 — Regra da Dependência**: O núcleo de negócio (Domain/Core) nunca deve depender de detalhes de implementação externa (banco de dados, UI, frameworks web).
* **R2 — Proibição de Ciclos**: Não são permitidos ciclos de dependência entre pacotes ou módulos.
* **R3 — Respeito a ADRs**: Mudanças que contrariem uma ADR existente exigem a emissão de uma nova ADR que formalize a substituição (`SUPERSEDED`).

---

## 7. Anti-Patterns
* **Leaky Abstractions**: Exposição de detalhes internos (ex.: SQL, anotações JPA `@Entity`) em interfaces públicas ou contratos de API.
* **God Service / Monolith Inside Microservice**: Um serviço que acumula todas as responsabilidades do domínio.
* **Distributed Monolith**: Microservices que compartilham o mesmo banco de dados ou que exigem deploy coordenado simultâneo.

---

## 8. Output Format

```markdown
# Architectural Analysis: [Sistema / Módulo]

## 1. Structural Overview
* **Estilo Detectado**: Clean Architecture / Monolito Modular
* **Acoplamento Geral**: Médio / Alto / Baixo
* **Aderência às ADRs**: Conforme / Divergente

## 2. Boundary Violations
* **Violação**: `src/domain/model/User.java` importa `org.springframework.data.annotation.Id`.
  * **Impacto**: Domínio acoplado ao framework Spring Data.
  * **Solução**: Usar mapeadores e anotações apenas na camada de persistência.

## 3. Dependency Graph & Cycles
* [Nenhum ciclo detectado | Ciclo detectado entre Módulo X e Y]
```

---

## 9. Examples
* **Caso**: Um controller acessa diretamente o repositório JPA sem passar pela camada de aplicação/serviço.
* **Veredito**: `Violação Arquitetural (P2)`.
* **Recomendação**: Encapsular a regra de negócio e orquestração transacional em um `UseCase` ou `Service`.
