---
name: refactor
description: >-
  Executa refatoração de código segura guiada por testes prévios (Red-Green-Refactor), eliminando code smells e débitos técnicos sem alterar o comportamento observável. Use esta skill quando o usuário digitar /refactor ou solicitar refatoração de código.
---

# Skill: /refactor — Refatoração Segura Guiada por Testes

Aplica transformações cirúrgicas de código para simplificar estruturas, melhorar legibilidade e modularidade, mantendo 100% da integridade comportamental.

> [!IMPORTANT]
> **Pré-requisito Mandatório**: Antes de realizar qualquer refatoração, deve existir uma suíte de testes passando. Se não houver testes, o primeiro passo é criar testes de caracterização (Characterization Tests) que congelem o comportamento atual.

---

## 1. Parâmetros de Entrada

Ao receber `/refactor [argumentos]`, extraia:
- `target`: Arquivo, método ou classe que receberá a refatoração.
- `goal`: Objetivo principal da refatoração (ex: "Extrair método", "Eliminar switch case com Strategy", "Reduzir complexidade ciclomática").

---

## 2. Protocolo de Refatoração (Ciclo Seguro)

1. **Validação do Estado Inicial (Baseline):**
   - Executar os testes existentes do componente. Todos devem estar verdes.
2. **Definição de Passos Atômicos:**
   - Decompor a refatoração em pequenas mudanças isoladas (ex: Rename -> Extract Variable -> Extract Method -> Move Class).
3. **Aplicação Incremental:**
   - Aplicar uma transformação por vez.
   - Reexecutar os testes a cada passo atômico para garantir que nada foi quebrado.
4. **Verificação de Regressão:**
   - Garantir que a API pública e os contratos externos permaneçam inalterados.
5. **Auditoria Pós-Refatoração:**
   - Validar que a complexidade ciclomática reduziu e que novos smells não foram introduzidos.

---

## 3. Saída Gerada

- Resumo das transformações aplicadas.
- Comparativo Antes vs Depois (diff ou código lado a lado).
- Confirmação de que os testes continuam passando.
