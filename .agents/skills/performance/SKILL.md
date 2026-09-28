---
name: performance
description: >-
  Identifica gargalos algorítmicos O(n^2), consultas de banco N+1, desperdício de memória e operações síncronas bloqueantes de I/O. Use esta skill quando o usuário digitar /performance ou solicitar diagnóstico de desempenho e escalabilidade.
---

# Skill: /performance — Análise de Desempenho e Eficiência

Inspeciona fluxos críticos de execução para eliminar gargalos de processamento, queries redundantes e vazamentos de recursos.

---

## 1. Parâmetros de Entrada

Ao receber `/performance [argumentos]`, extraia:
- `target`: Arquivo, método, query ou pacote a ser inspecionado. Se omitido, avalie o fluxo principal do projeto atual.
- `profile` *(opcional)*: `cpu`, `memory`, `database` ou `full` (padrão).

---

## 2. Vetores de Análise de Desempenho

1. **Eficiência Algorítmica:**
   - Detecção de loops aninhados com complexidade temporal $O(n^2)$ ou superior.
   - Pesquisas lineares repetidas em coleções não indexadas (usar Map/Set em vez de List).
2. **Acesso a Dados e Persistência:**
   - Detecção do anti-pattern N+1 queries (em ORMs como Hibernate, TypeORM, Prisma, Entity Framework).
   - Ausência de paginação em consultas que retornam coleções potencialmente grandes.
   - Projeções incompletas (`SELECT *` carregando colunas e relacionamentos desnecessários).
3. **Gerenciamento de Recursos e Memória:**
   - Fechamento inadequado de conexões, sockets ou streams (leak de file descriptors).
   - Retenção indevida de referências em singletons ou caches estáticos sem TTL.
4. **I/O e Concorrência:**
   - Operações bloqueantes síncronas executadas dentro do event-loop ou da thread principal.

---

## 3. Saída Gerada

- Tabela de gargalos identificados com estimativa de impacto em escala.
- Demonstração do código original vs código otimizado com redução de complexidade.
