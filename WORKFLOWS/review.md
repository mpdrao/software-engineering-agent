# Workflow: /review

---

## 1. Objetivo
Realizar revisão técnica aprofundada de um Pull Request, diff git ou conjunto de arquivos alterados, garantindo corretude lógica, ausência de regressões, legibilidade, concisão e aderência aos padrões de Clean Code e SOLID.

---

## 2. Skills Utilizadas
* [SKILLS/code-review](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/code-review/SKILL.md)
* [SKILLS/clean-code](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/clean-code/SKILL.md)
* [SKILLS/solid](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/solid/SKILL.md)
* [SKILLS/security](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/security/SKILL.md)

---

## 3. Arquivos Consultados
* `git diff` ou lista de arquivos alterados no commit/PR.
* Classes de teste alteradas ou adicionadas.
* `QUALITY-GATES/severity.md` e `QUALITY-GATES/gate.md`.

---

## 4. Sequência de Análise
1. **Compreensão do Escopo da Alteração**: Inspecionar os arquivos modificados e identificar a intenção do PR.
2. **Inspeção de Corretude & Regressões**:
   * O código quebra contratos públicos de API existentes?
   * Existem condições de corrida, vazamento de conexões ou exceções desprotegidas?
3. **Inspeção de Clean Code & SOLID**:
   * O código adicionado introduz métodos gigantes ou parâmetros booleanos de flag?
   * Foram violadas regras de responsabilidade única (SRP)?
4. **Inspeção Rápida de Segurança**:
   * Há credenciais gravadas ou concatenação perigosa de queries?
5. **Verificação de Testes do PR**:
   * Novos testes foram adicionados cobrindo os cenários alterados?
6. **Determinação do Quality Gate**:
   * Se houver P0 ou P1 $\rightarrow$ `CHANGES_REQUESTED (BLOCKED)`.
   * Se houver apenas P2 $\rightarrow$ `REVIEW`.
   * Se houver apenas P3 ou nenhum apontamento $\rightarrow$ `APPROVED (PASS)`.

---

## 5. Formato da Saída
* Resumo do Veredito (`APPROVED` | `CHANGES_REQUESTED`).
* Matriz de Findings com Severidade (P0 a P3), localização e código de correção sugerido.
* Avaliação da suíte de testes do PR.

---

## 6. Condições de Sucesso
* Revisão restrita aos arquivos modificados no PR.
* Nenhum comentário bloqueador sem código prescritivo de resolução.
