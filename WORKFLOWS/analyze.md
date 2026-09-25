# Workflow: /analyze

---

## 1. Objetivo
Executar uma análise técnica investigativa profunda sob demanda sobre um módulo, pacote, arquivo ou problema técnico específico, identificando sua estrutura, responsabilidades, riscos latentes e oportunidades de melhoria.

---

## 2. Skills Utilizadas
* [SKILLS/architecture](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/architecture/SKILL.md)
* [SKILLS/code-review](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/code-review/SKILL.md)
* [SKILLS/clean-code](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/clean-code/SKILL.md)
* [SKILLS/solid](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/solid/SKILL.md)

---

## 3. Arquivos Consultados
* Arquivos do módulo ou funcionalidade alvo sob análise.
* `PROJECTS/<projeto>/context.md` (caso exista).
* ADRs relevantes em `PROJECTS/<projeto>/decisions/` ou `BRAIN/09-DECISIONS/`.

---

## 4. Sequência de Análise
1. **Identificação de Escopo**: Mapear quais classes, interfaces e arquivos compõem o componente alvo.
2. **Avaliação Estrutural & Dependências**: Inspecionar importações e dependências externas para verificar se o componente respeita os limites de contexto.
3. **Análise de Lógica & Qualidade**: Inspecionar métodos críticos avaliando complexidade ciclomática, legibilidade e tratamento de exceções.
4. **Verificação SOLID**: Mapear se a classe acumula responsabilidades colaterais (violação de SRP) ou acoplamento direto a instâncias concretas (violação de DIP).
5. **Compilação de Riscos**: Identificar gargalos, pontos de quebra e dívidas técnicas latentes.

---

## 5. Formato da Saída
Seguir a estrutura canônica de análise técnica:
```markdown
# Analysis: [Alvo Analisado]

## Context
Resumo do propósito do componente e escopo da análise.

## Findings
Lista de apontamentos estruturados (ID, Severity, Location, Problem, Evidence, Impact, Recommendation).

## Architecture
Avaliação do isolamento e dependências.

## Risks
Principais riscos identificados.

## Recommendations
Ações corretivas priorizadas (Curto, Médio e Longo Prazo).

## Quality Gate
Veredito preliminar (`PASS` | `REVIEW` | `BLOCKED`).

## Knowledge Candidates
Novas hipóteses para registro em `BRAIN/99-INBOX/`.
```

---

## 6. Condições de Sucesso
* O alvo é analisado sem alterar nenhuma linha de código.
* Todas as afirmações contêm evidência comprovada por linha e arquivo.
* Relatório emitido no formato canônico.
