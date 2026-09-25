# Skill: Angular Engineering & Modern Frontend

---

## 1. Purpose
A skill **angular** audita e orienta a construção de SPAs robustas utilizando **Angular** (versões modernas com Standalone Components e Signals), avaliando reatividade com RxJS, estratégia de detecção de mudanças (ChangeDetection), injeção de dependência e desacoplamento de estado.

---

## 2. When to Use
* Durante auditoria (`/audit`) ou revisão (`/review`) de frontends em Angular.
* Ao desenhar arquitetura de componentes, serviços de dados e guardas de rota (*route guards*).
* Ao investigar vazamentos de memória por inscrições RxJS não canceladas (*subscription leaks*).

---

## 3. Inputs
* Arquivos `.ts`, `.html` e `.scss` do projeto Angular.
* Configurações de workspace (`angular.json`, `tsconfig.json`).
* Dependências em `package.json`.

---

## 4. Required Context
* [SKILLS/clean-code](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/clean-code/SKILL.md).
* Padrões em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Padrão de Arquitetura de Componentes**:
   * O projeto utiliza componentes autônomos (*Standalone Components*) ou ainda depende de `NgModules` legados?
   * Componentes são decompostos em *Smart (Container)* e *Dumb (Presentational)*?
2. **Gerenciamento de Reatividade & Vazamento de Memória**:
   * As inscrições RxJS (`.subscribe()`) são finalizadas com `takeUntilDestroyed()`, operador `take(1)` ou o pipe `async` no template?
   * Há adoção moderna de **Angular Signals** (`signal()`, `computed()`, `effect()`) para estado local?
3. **Change Detection Strategy**:
   * Componentes de apresentação utilizam `ChangeDetectionStrategy.OnPush` para evitar ciclos globais de verificação desnecessários?
4. **Formulários & Validação**:
   * Uso adequado de *ReactiveFormsModule* tipado em vez de *Template-driven forms* para formulários complexos.
5. **Tipagem & TypeScript**:
   * Proibição de tipos `any` genéricos; uso de interfaces estritas e tipos discriminados.

---

## 6. Rules
* **R1 — Proibição de Subscription Leaks**: Nenhuma inscrição manual em Observable em componentes deve sobreviver à destruição do componente.
* **R2 — OnPush nos Componentes Dumb**: Componentes que apenas recebem `@Input()` e emitem `@Output()` devem utilizar compulsoriamente `ChangeDetectionStrategy.OnPush`.
* **R3 — Proibição de Lógica Pesada no Template HTML**: Proibido invocar métodos que recalculam coleções diretamente na interpolação do template (`{{ calculateTotal() }}`).

---

## 7. Anti-Patterns
* **Calling Methods in Templates**: Chamar métodos que executam cálculos pesados dentro do template, reexecutando a cada ciclo de Change Detection.
* **Unsubscribed Observables**: Chamar `service.getData().subscribe(...)` dentro de `ngOnInit()` sem desinscrição no `ngOnDestroy()`.
* **State Mutation in Inputs**: Modificar diretamente objetos passados via `@Input()` em vez de emitir eventos.

---

## 8. Output Format

```markdown
# Angular Audit: [Componente / Módulo]

## Saúde Reativa
* Standalone Components: Sim / Não
* Gestão de Inscrições: Segura (Pipe async / takeUntilDestroyed) / Risco de Leak
* Change Detection: OnPush / Default

## Findings
* **[P1] Vazamento de Inscrição RxJS**:
  * **Arquivo**: `src/app/users/user-list.component.ts#L35`
  * **Problema**: `this.userService.getUsers().subscribe(...)` sem cancelamento no lifecycle.
  * **Solução**: Migrar para pipe `async` no template ou aplicar `takeUntilDestroyed()`.
```

---

## 9. Examples
* **Caso**: Interpolação HTML contendo `<span>{{ getFormattedPrice(product) }}</span>`.
* **Veredito**: `P2 - IMPORTANT`.
* **Recomendação**: Converter a função para um **Custom Pipe** puro ou propriedade de **Signal** computado.
