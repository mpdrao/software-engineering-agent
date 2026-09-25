# Workflow: /performance

---

## 1. Objetivo
Identificar potenciais gargalos de processamento, ineficiências de complexidade algorítmica ($O(n^2)$ ou superior), problemas de alocação excessiva de memória, vazamento de recursos e problemas clássicos de banco de dados (ex.: problema do N+1).

---

## 2. Skills Utilizadas
* [SKILLS/code-review](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/code-review/SKILL.md)
* [SKILLS/clean-code](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/clean-code/SKILL.md)

---

## 3. Arquivos Consultados
* Métodos transacionais e loops intensivos de processamento.
* Mapeamentos ORM (JPA/Hibernate entities, fetch types, queries).
* Configurações de pool de conexões (HikariCP, etc.).

---

## 4. Sequência de Análise
1. **Auditoria de Consultas e Persistência**:
   * Detecção do anti-padrão **N+1 Queries** em relacionamentos `EAGER` ou loops contendo chamadas a `repository.findById()`.
   * Falta de paginação em listagens potencialmente infinitas.
2. **Complexidade Algorítmica**:
   * Identificar loops aninhados em coleções grandes que podem ser convertidos para Maps ou Sets ($O(1)$ lookup).
3. **Gerenciamento de Recursos & I/O**:
   * Uso obrigatório de `try-with-resources` para streams, conexões e sockets.
   * Concorrência desprotegida ou sincronização excessiva gerando contenção de threads (*lock contention*).
4. **Cache & Reatividade**:
   * Uso adequado de cache local ou distribuído para dados imutáveis de alta leitura.

---

## 5. Formato da Saída
* Lista de gargalos de performance classificados por impacto.
* Antes vs. Depois com ganho estimado de ordem de complexidade.

---

## 6. Condições de Sucesso
* Toda recomendação de performance é fundamentada em análise algorítmica comprovada, evitando otimizações prematuras cosméticas.
