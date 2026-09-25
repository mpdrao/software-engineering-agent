---
type: anti-pattern
status: candidate # candidate | validated | standard | deprecated
domain: patterns # patterns | architecture | code-quality | security | database
id: ANT-000
title: "Nome do Anti-Pattern"
tags: [anti-pattern, code-smell, technical-debt]
created: YYYY-MM-DD
updated: YYYY-MM-DD
source: "Revisão de Código / Auditoria"
confidence: high
---

# ANT-000: Nome do Anti-Pattern

## 1. Problema e Definição
Definição clara da má prática, armadilha arquitetural ou code smell recorrente e por que ela degrada a sustentabilidade do sistema.

---

## 2. Sintomas Visíveis
* Classes com milhares de linhas e muitas dependências injetadas (God Object / God Class);
* Dificuldade extrema para escrever testes unitários sem dezenas de mocks;
* Efeitos colaterais imprevisíveis ao alterar uma funcionalidade aparentemente isolada;
* Travamento ou degradação de conexões sob carga moderada.

---

## 3. Causa Raiz
Por que os desenvolvedores caem nessa armadilha? (Ex.: conveniência temporária, falta de compreensão de limites de contexto, atalhos de entrega rápida).

---

## 4. Exemplo Negativo (Como NÃO fazer)
```java
// Código ilustrando o anti-pattern
public class OrderManager {
    // Mistura de lógica de banco, regras de negócio, envio de email e HTTP
}
```

---

## 5. Solução Canônica & Refatoração (Como fazer certo)
```java
// Código refatorado seguindo separação de responsabilidades e coesão
```

---

## 6. Quando é Tolerável (Exceções Pragmaticamente Aceitas)
Existe algum cenário extremo em que esse padrão é temporariamente aceito? Se sim, documente a justificativa e os limites estritos de contenção.
