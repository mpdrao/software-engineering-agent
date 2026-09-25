---
type: decision
status: validated
domain: architecture
id: ADR-001
title: "Adoção de Monolito Modular em vez de Microservices — Margem.AI"
tags: [adr, decision, architecture, modular-monolith, microservices]
created: 2026-09-25
updated: 2026-09-25
source: "Workflow /architect"
confidence: high
---

# ADR-001: Adoção de Monolito Modular em vez de Microservices

## 1. Status
`ACCEPTED`

---

## 2. Contexto
O **Margem.AI** é uma solução voltada para microempreendedores individuais com foco em precificação e controle de fluxo de caixa. O sistema opera com equipes de desenvolvimento enxutas (1 a 3 engenheiros) e possui um volume transacional inicial moderado (estimado em menos de 500 RPS). Os limites de domínio (Identidade, Custos, Produtos, Precificação) são bem delimitados, mas interagem frequentemente em tempo real durante simulações financeiras.

---

## 3. Problema
Qual estilo arquitetural deve ser adotado para suportar o desenvolvimento ágil, baixo custo de infraestrutura e fácil manutenção, sem incorrer na sobrecarga operacional (*operational overhead*) e complexidade de consistência distribuída?

---

## 4. Decisão
Decidimos construir o backend do Margem.AI como um **Monolito Modular** em **Spring Boot 3.4 / Java 21**, mantendo limites de contexto estritamente isolados em pacotes e módulos de serviço, com um único banco de dados relacional **PostgreSQL 16**.

O desacoplamento entre contextos que não exigem consistência transacional síncrona rígida é realizado através de **Spring ApplicationEvents** in-memory, eliminando a dependência prematura de um message broker externo (Kafka ou RabbitMQ).

---

## 5. Alternativas Consideradas

### Alternativa A: Arquitetura de Microservices Distribuídos
* **Descrição**: Separar a plataforma em 4 microserviços independentes (`auth-service`, `cost-service`, `product-service`, `pricing-service`), cada um com seu próprio banco de dados e comunicação via gRPC / RabbitMQ.
* **Vantagens**: Deploy independente de cada serviço.
* **Desvantagens**:
  * Sobrecarga de rede (latência adicional entre serviços em cálculos de preço);
  * Complexidade de transações distribuídas (Saga pattern) para manter consistência;
  * Custo financeiro de múltiplos containers e instâncias de banco;
  * Complexidade excessiva para o tamanho atual da equipe e produto.
* **Razão do Descarte**: **Rejeitado pelo Filtro de 5 Perguntas do SE-OS (Anti-Overengineering)**. Não há requisitos de escala de equipe ou volume de tráfego que justifiquem a complexidade acidental de microserviços neste estágio.

### Alternativa B: Monolito Não Estruturado (Spaghetti Monolith)
* **Descrição**: Sistema monolítico com entidades e serviços altamente acoplados, sem isolamento de pacotes e chamadas cruzadas diretas a repositórios alheios.
* **Razão do Descarte**: Inviabiliza testes isolados e gera dependências circulares.

---

## 6. Consequências

### Consequências Positivas (Ganhos)
* **Custo Mínimo de Infraestrutura:** Um único container de aplicação e uma instância PostgreSQL atendem perfeitamente a demanda.
* **Zero Latência de Rede Inter-Serviços:** Chamadas entre domínios (ex: `ProductService` chamando `CategoryService`) ocorrem in-memory.
* **Desenvolvimento e Testes Simplificados:** A suíte completa de testes pode ser executada em segundos com um banco H2 local ou Testcontainers.
* **Evolutividade Garantida:** Como os limites modulares estão preservados, qualquer módulo pode ser extraído para um serviço autônomo no futuro se a necessidade de escala exigir.

### Consequências Negativas (Custos & Riscos)
* **Deploy Unificado:** Uma alteração no módulo de custos exige o deploy conjunto de toda a aplicação backend.
* **Risco de Vazamento de Dependências:** Engenheiros menos experientes podem tentar injetar repositórios de outros domínios diretamente. Deve ser contido via testes de arquitetura (ArchUnit) e revisões de código rigorosas.

---

## 7. Referências & Links
* Arquitetura de Limites: `[[ARCH-001-context-boundaries]]`
* Princípios: `[[00-CORE/engineering-principles]]`
* Filtro de Tomada de Decisão: `[[AGENT/decision-making]]`
