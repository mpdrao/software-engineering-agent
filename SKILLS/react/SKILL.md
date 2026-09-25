# Skill: React & Modern Frontend Engineering

---

## 1. Purpose
A skill **react** audita e orienta a construção de aplicações em **React** (versões modernas com Hooks, Server Components e Next.js), avaliando o ciclo de vida de renderização, imutabilidade de estado, dependências de hooks (`useEffect`, `useCallback`, `useMemo`), performance e separação de responsabilidades na UI.

---

## 2. When to Use
* Durante o workflow `/audit` ou `/review` de bases de código React / Next.js.
* Ao identificar re-renderizações desnecessárias, gargalos visuais ou loops infinitos de efeitos.
* Ao desenhar custom hooks reutilizáveis ou gerenciadores de estado global.

---

## 3. Inputs
* Arquivos `.tsx`, `.jsx`, `.ts` e estilos associados.
* Manifestos de pacotes (`package.json`) e configurações (`next.config.js`, `tsconfig.json`).

---

## 4. Required Context
* [SKILLS/clean-code](../clean-code/SKILL.md).
* Padrões em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Regras de Hooks & Dependências**:
   * O array de dependências de `useEffect`, `useMemo` e `useCallback` está completo e livre de avisos de lint (*exhaustive-deps*)?
   * Efeitos colaterais (`useEffect`) estão sendo usados indevidamente para sincronizar estados que poderiam ser calculados na renderização?
2. **Imutabilidade do Estado**:
   * O estado do componente (`useState`, `useReducer`) é tratado como estritamente imutável?
   * Existem mutações diretas em arrays ou objetos (`state.push()`, `state.prop = val`) impedindo a re-renderização correta?
3. **Performance de Renderização**:
   * Componentes pesados utilizam `React.memo` quando recebem props imutáveis?
   * Callbacks passados para componentes filhos memorizados são estabilizados via `useCallback`?
4. **Gerenciamento de Estado**:
   * Há problema de *Prop Drilling* excessivo (> 4 níveis de passagem de props)?
   * O estado global é reservado para dados verdadeiramente compartilhados, evitando inflar o Context API com dados de alta frequência de atualização?
5. **Arquitetura de Componentes**:
   * Lógica de negócio e chamadas de API encapsuladas em **Custom Hooks** separados dos componentes puramente visuais.

---

## 6. Rules
* **R1 — Proibição de Mutação Direta de Estado**: Qualquer mutação direta em objetos de estado sem criar cópia/spread é considerada erro grave.
* **R2 — Respeito ao Exhaustive Deps**: Nunca omitir dependências do array de `useEffect` sem comentário e justificativa arquitetural documentada.
* **R3 — Não Usar useEffect para Computar Estado Derivado**: Valores que dependem de props ou estados existentes devem ser calculados inline durante a renderização (ou com `useMemo` se caros).

---

## 7. Anti-Patterns
* **Deriving State via useEffect**: Criar um `useState` secundário atualizado dentro de um `useEffect` apenas para espelhar uma prop.
* **Inline Object Creation in Props**: Passar objetos literais novos a cada render (`style={{ margin: 0 }}` ou `onClick={() => doSomething()}`) para componentes que dependem de comparação rasa.
* **Giant Components**: Componentes React de mais de 300 linhas misturando chamadas de rede, formatação e renderização.

---

## 8. Output Format

```markdown
# React Audit: [Componente]

## Saúde dos Hooks
* Arrays de Dependência: Corretos / Violação de Exhaustive Deps
* Estado Imutável: Conforme / Alerta de Mutação Direta
* Custom Hooks: Bem modularizados / Lógica acoplada no JSX

## Findings
* **[P2] Estado Derivado Redundante**:
  * **Arquivo**: `src/components/UserProfile.tsx#L18`
  * **Problema**: Uso de `useEffect` para calcular `fullName` a partir de `firstName` e `lastName`.
  * **Solução**: `const fullName = `${firstName} ${lastName}`;` calculado diretamente na renderização.
```

---

## 9. Examples
* **Caso**: O desenvolvedor alterou o array no estado via `items.sort()` antes de chamar `setItems(items)`.
* **Veredito**: `P1 - CRITICAL`.
* **Ação**: O método `.sort()` muta a referência original in-place. Deve-se fazer `[...items].sort()` para garantir nova referência e re-renderização.
