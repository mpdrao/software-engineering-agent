# Skill: Performance Optimization & Profiling

---

## 1. Purpose
A skill **performance** diagnostica ineficiências de processamento, complexidade algorítmica desnecessária ($O(n^2)$, $O(2^n)$), vazamentos de memória (leaks), contenção de concorrência, overhead de serialização e gargalos de I/O em endpoints críticos.

---

## 2. When to Use
* Durante o workflow `/performance` ou na etapa de performance do `/audit`.
* Ao investigar degradação de tempo de resposta sob carga ou picos de CPU/memória.
* Ao desenhar algoritmos de processamento em lote ou pipelines de stream.

---

## 3. Inputs
* Código-fonte de loops críticos, métodos de processamento e transformações de coleções.
* Resultados de benchmarks (JMH, k6, Locust) ou logs de profiler (VisualVM, Async-profiler, JFR) se disponíveis.
* Mapeamento de estruturas de dados utilizadas.

---

## 4. Required Context
* [AGENT/behavior.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/behavior.md) (Distinguir evidência comprovada de hipótese de lentidão).
* Diretrizes em `BRAIN/06-PERFORMANCE/`.

---

## 5. Analysis Procedure
1. **Auditoria de Complexidade Assintótica ($O(n)$)**:
   * Identificar loops aninhados iterando sobre listas para buscas que poderiam ser indexadas em $O(1)$ via Hash Table ou Map.
2. **Auditoria de Alocação de Memória & Garbage Collection**:
   * O código cria objetos desnecessários em loops de alta frequência (ex.: concatenação de strings com `+` em loops longos em vez de `StringBuilder`)?
   * Existem coleções estáticas que acumulam registros indefinidamente sem política de expiração (*memory leak*)?
3. **Auditoria de Concorrência & Threads**:
   * Há sincronização excessiva (`synchronized` em blocos grandes) causando contenção desnecessária de threads?
   * O código utiliza estruturas concorrentes adequadas (`ConcurrentHashMap`, `AtomicLong`) em vez de travas pesadas?
4. **Auditoria de I/O & Rede**:
   * As chamadas de rede externas e banco são feitas de forma bloqueante sequencial onde poderiam ser paralelas ou em batch?

---

## 6. Rules
* **R1 — Otimização Prematura é a Raiz de Todo o Mal**: Não substitua código limpo e legível por código obscuro sob a premissa de ganho de performance sem medição ou profiling comprovado.
* **R2 — Fechamento Estrito de I/O**: Todo recurso de I/O (sockets, streams de disco, conexões de banco) deve ser fechado de forma garantida (`try-with-resources`).
* **R3 — Limites de Alocação em Memória**: Proibido carregar datasets completos do banco na memória para aplicar filtros que o banco de dados pode resolver na cláusula `WHERE`.

---

## 7. Anti-Patterns
* **String Concatenation in Loops**: Uso de `str += "x"` em iterações massivas, gerando dezenas de milhares de objetos temporários no heap.
* **Unbounded Caches**: Caches locais em `HashMap` sem limite máximo de tamanho (LRU) ou TTL, levando a `OutOfMemoryError`.
* **Synchronized World**: Métodos sincronizados inteiros que bloqueiam o throughput da aplicação sob alta concorrência.

---

## 8. Output Format

```markdown
# Performance Analysis: [Componente]

## Complexidade Algorítmica
* Método `findDuplicates()`: Atual $O(n^2)$ $\rightarrow$ Otimizável para $O(n)$.

## Diagnóstico de Recursos
* **Vazamento de Conexão**: `ReportGenerator.java#L58` abre stream de rede sem bloco `try-with-resources`.
```

---

## 9. Examples
* **Caso**: O método verifica se elementos de uma lista de 50.000 itens estão em outra lista fazendo `listA.contains(item)` dentro de um loop em `listB` (complexidade $O(N \times M)$).
* **Veredito**: `P2 - IMPORTANT`.
* **Recomendação**: Converter `listA` para `HashSet` antes do loop, reduzindo a complexidade global para $O(N + M)$ com lookup em $O(1)$.
