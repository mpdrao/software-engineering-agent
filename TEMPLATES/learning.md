---
type: learning # learning | bug
status: candidate # candidate | validated | standard | deprecated
domain: code-quality # sdd | architecture | code-quality | security | testing | performance | stack | devops
id: LRN-000
title: "Título da Lição Aprendida / Post-Mortem"
tags: [learning, bug, post-mortem, troubleshooting]
created: YYYY-MM-DD
updated: YYYY-MM-DD
source: "Projeto / Incidente / Teste"
confidence: medium # high | medium | low
---

# LRN-000: Título da Lição Aprendida

## 1. Problema Observado
Descrição do sintoma, falha, exceção ou comportamento anômalo ocorrido em ambiente de desenvolvimento, teste ou produção.

---

## 2. Investigação & Diagnóstico
* **Comportamento Inesperado**: O que aconteceu concretamente.
* **Comportamento Esperado**: O que deveria ter acontecido.
* **Causa Raiz Identificada**: Explicação técnica precisa (ex.: vazamento de conexão no pool HikariCP por falta de fechamento em bloco try-finally, race condition em mapa concorrente, etc.).

---

## 3. Solução Implementada & Validada
Descrição da correção definitiva com antes vs. depois:

### Código com Falha (Antes)
```java
// Código problemático
```

### Código Corrigido (Depois)
```java
// Código corrigido e resiliente
```

---

## 4. Como Prevenir a Recorrência
* **Regra de Engenharia**: Diretriz técnica a ser observada em revisões de código.
* **Teste Automatizado Adicionado**: Teste unitário ou de mutação que detecta a regressão.
* **Ferramenta / Linter**: Regra estática configurada para barrar o problema no pipeline.

---

## 5. Rastreabilidade
* `[[anti-patterns/NOME_DO_ANTI_PADRAO]]`
* Arquivos afetados no projeto de origem.
