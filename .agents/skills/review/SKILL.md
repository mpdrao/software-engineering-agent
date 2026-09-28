---
name: review
description: >-
  Executa revisão técnica aprofundada de código, PR ou diff avaliando riscos de regressão, manutenibilidade, segurança e cobertura de testes antes do merge. Use esta skill quando o usuário digitar /review ou solicitar code review.
---

# Skill: /review — Revisão de Código e Pull Request

Analisa criticamente alterações de código com foco na prevenção de regressões, clareza técnica e preservação da arquitetura.

---

## 1. Parâmetros de Entrada

Ao receber `/review [argumentos]`, extraia:
- `target`: Arquivo, lista de arquivos ou indicador de diff (ex: `git diff`, `HEAD~1`, arquivo específico).
- `scope` *(opcional)*: `diff` (apenas as linhas alteradas) ou `file` (o contexto completo do arquivo). Se omitido, avalie o `diff` no contexto do arquivo.

---

## 2. Protocolo de Revisão (Checklist Técnico)

Avalie as alterações sob quatro dimensões fundamentais:

1. **Corretude e Risco de Regressão:**
   - Efeitos colaterais não previstos em outros módulos.
   - Condições de corrida, problemas de concorrência ou mutabilidade indevida.
   - Tratamento adequado de casos limite (valores nulos, coleções vazias, timeouts).
2. **Qualidade e Sustentabilidade de Código:**
   - Nomenclatura explícita de variáveis e funções.
   - Respeito ao princípio de responsabilidade única (SRP) e métodos concisos.
   - Ausência de código duplicado e complexidade desnecessária.
3. **Segurança:**
   - Ausência de segredos ou tokens hardcoded.
   - Sanitização de inputs do usuário e validação de limites.
4. **Testes:**
   - As alterações estão acompanhadas de testes unitários ou de integração?
   - Os testes asseveram o comportamento real ou são superficiais?

---

## 3. Veredito e Formato de Saída

Emita o parecer técnico:
- **`APPROVED`**: Mudanças sólidas, sem riscos críticos ou débitos introduzidos.
- **`CHANGES_REQUESTED`**: Presença de bugs potenciais, brechas de segurança ou ausência de testes essenciais.

Para cada finding apontado:
- Citar arquivo e linha exata.
- Explicar o risco técnico objetivo.
- Fornecer bloco de código prescritivo com a solução recomendada.
