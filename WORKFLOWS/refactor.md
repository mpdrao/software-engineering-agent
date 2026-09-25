# Workflow: /refactor

---

## 1. Objetivo
Executar ou orientar a refatoração segura de código legado ou com dívida técnica, melhorando seu design, legibilidade e conformidade arquitetural **sem alterar seu comportamento observável externo**, suportado por uma rede sólida de testes automatizados.

---

## 2. Skills Utilizadas
* [SKILLS/clean-code](../SKILLS/clean-code/SKILL.md)
* [SKILLS/solid](../SKILLS/solid/SKILL.md)
* [SKILLS/testing](../SKILLS/testing/SKILL.md)
* [SKILLS/code-review](../SKILLS/code-review/SKILL.md)

---

## 3. Arquivos Consultados
* Componente alvo da refatoração.
* Suíte de testes existente cobrindo o componente.
* Classes clientes que dependem do componente.

---

## 4. Sequência de Análise & Execução
1. **Verificação da Rede de Segurança (Safety Net)**:
   * Existem testes automatizados determinísticos que cobrem o componente?
   * *Regra de Bloqueio*: Se não houver testes cobrindo o comportamento atual, a refatoração é suspensa até que testes de caracterização (*characterization tests*) sejam criados.
2. **Identificação dos Code Smells Específicos**:
   * Listar precisamente quais smells motivam a refatoração (God Class, Long Method, Feature Envy, Primitive Obsession).
3. **Plano de Passos Pequenos e Atômicos**:
   * Decompor a refatoração em micropassos (ex.: Extrair Método $\rightarrow$ Rodar Testes $\rightarrow$ Renomear Variável $\rightarrow$ Rodar Testes $\rightarrow$ Injetar Dependência $\rightarrow$ Rodar Testes).
4. **Execução Incremental**:
   * Aplicar as transformações mantendo compatibilidade de interface.
5. **Validação Final**:
   * Garantir que todos os testes passem com 100% de sucesso e que a complexidade ciclomática tenha sido reduzida.

---

## 5. Formato da Saída
* Diagnóstico inicial dos smells.
* Passos atômicos executados.
* Comparativo Antes vs. Depois.
* Confirmação da passagem dos testes.

---

## 6. Condições de Sucesso
* Comportamento externo preservado integralmente.
* Testes continuam passando sem alteração nas asserções de negócio.
