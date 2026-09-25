# Skill: Database Design & Query Analysis

---

## 1. Purpose
A skill **database** audita e orienta o design de persistência de dados (relacional e NoSQL), estratégias de indexação, integridade referencial, limites transacionais ACID, níveis de isolamento e detecção de consultas ineficientes (como o problema N+1, full table scans e bloqueios de tabela).

---

## 2. When to Use
* Durante o workflow `/audit` ou ao criar/modificar esquemas de banco de dados.
* Ao revisar scripts de migração (Flyway, Liquibase, Prisma, etc.).
* Ao analisar lentidão em endpoints com gargalos comprovados de I/O em banco.

---

## 3. Inputs
* Scripts de migração DDL/DML (`db/migration/`, arquivos `.sql`).
* Mapeamento de entidades ORM (JPA/Hibernate, TypeORM, SQLAlchemy, etc.).
* Configuração de conexões e pool de banco (`application.yml`, `.env`).

---

## 4. Required Context
* [AGENT/decision-making.md](../../AGENT/decision-making.md) (Evitar complexidade NoSQL quando modelo relacional atender perfeitamente).
* Diretrizes em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Modelagem & Normalização**:
   * O esquema atende às formas normais básicas (3FN) ou possui desnormalizações justificadas por alta taxa de leitura?
   * As chaves primárias são imutáveis e chaves estrangeiras garantem integridade referencial?
2. **Estratégia de Índices**:
   * Colunas utilizadas frequentemente em filtros `WHERE`, `JOIN` e `ORDER BY` possuem índices correspondentes?
   * Existem índices redundantes ou índices compostos com ordem de colunas incorreta em relação às consultas?
3. **Auditoria Transacional**:
   * Operações críticas de mutação múltipla estão encapsuladas em transações atômicas?
   * O nível de isolamento é adequado para evitar leituras sujas (*dirty reads*) ou leituras não repetíveis sem causar contenção excessiva?
4. **Varredura de Consultas Ineficientes**:
   * Detecção do anti-padrão **N+1 queries** através de loops iterando sobre entidades com mapeamento `LAZY` ou chamadas repetidas ao repositório.
   * Presença de queries `SELECT *` desnecessárias em tabelas com dezenas de colunas ou colunas binárias pesadas (`BLOB/CLOB`).

---

## 6. Rules
* **R1 — Proibição de Migrações Destrutivas Sem Passo Intermediário**: Remoções de colunas devem ser feitas em etapas (depreciação $\rightarrow$ remoção de leitura $\rightarrow$ drop de coluna) para viabilizar zero downtime.
* **R2 — Paginação Obrigatória em Listagens**: Qualquer consulta que retorne listas deve exigir limites de paginação (`LIMIT`/`OFFSET` ou *cursor-based*).
* **R3 — Chaves Estrangeiras Obrigatórias em RDBMS**: Não delegar integridade referencial exclusivamente à aplicação em bancos relacionais.

---

## 7. Anti-Patterns
* **N+1 Query Problem**: Executar 1 consulta para obter uma lista de $N$ registros e depois $N$ consultas individuais para buscar dados relacionados.
* **Missing Index on Foreign Keys**: Esquecer de criar índices em colunas de chaves estrangeiras, degradando dramaticamente operações de `JOIN` e `DELETE CASCADE`.
* **Database as a Queue**: Utilizar tabelas relacionais com polling constante para atuar como fila de mensageria em vez de um message broker adequado.

---

## 8. Output Format

```markdown
# Database Analysis: [Módulo / Schema]

## Resumo do Modelo
* Tipo de Banco: Relacional (PostgreSQL) / NoSQL
* Integridade Referencial: Adequada / Frágil
* Qualidade de Indexação: Ótima / Índices Ausentes

## Findings de Persistência
* **[P2] Consulta N+1 Detectada**:
  * **Arquivo**: `src/main/java/com/app/repository/InvoiceRepo.java#L45`
  * **Problema**: O loop itera faturas e busca itens individualmente via `itemRepo.findByInvoiceId()`.
  * **Solução**: Utilizar `JOIN FETCH` ou `@EntityGraph` para carregar faturas e itens em uma única query otimizada.
```

---

## 9. Examples
* **Caso**: Script de migração cria tabela `user_tokens` sem índice na coluna `user_id`, usada em 100% das autenticações.
* **Veredito**: `P2 - IMPORTANT`.
* **Recomendação**: Adicionar `CREATE INDEX idx_user_tokens_user_id ON user_tokens(user_id);`.
