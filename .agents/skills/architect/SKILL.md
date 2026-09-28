---
name: architect
description: >-
  Modela decisões e estruturas arquiteturais em níveis C4, avalia alternativas com o filtro anti-sobre-engenharia e emite ADRs formais. Use esta skill quando o usuário digitar /architect ou solicitar desenho arquitetural / criação de ADR.
---

# Skill: /architect — Desenho de Arquitetura & Decisões (ADR)

Estrutura soluções arquiteturais pragmáticas, dimensionando limites de contexto, contratos entre componentes e registrando decisões técnicas fundamentadas.

---

## 1. Parâmetros de Entrada

Ao receber `/architect [argumentos]`, extraia:
- `domain`: Domínio ou funcionalidade em questão (ex: "Faturamento Assíncrono").
- `problem`: Desafio técnico, restrição ou trade-off a ser endereçado.

---

## 2. O Filtro de 5 Perguntas Anti-Overengineering

Antes de recomendar qualquer padrão distribuído ou tecnologia complexa, avalie obrigatoriamente:
1. **O problema existe hoje em produção ou é puramente hipotético?**
2. **A solução mais simples (ex: monólito modular, tabela relacional, job síncrono) é suficiente?**
3. **Qual é o custo operacional e cognitivo de manter essa abstração?**
4. **Essa arquitetura pode ser evoluída incrementalmente quando a escala real exigir?**
5. **A equipe atual domina e tem capacidade de sustentar essa tecnologia?**

---

## 3. Protocolo de Modelagem

1. **Contexto e Restrições:**
   - Definir SLAs, volumetria esperada, limites de consistência (eventual vs forte).
2. **Diagramação C4:**
   - Elaborar diagramas Mermaid nos níveis relevantes (C1 Context, C2 Container ou C3 Component).
3. **Análise de Trade-offs:**
   - Comparar no mínimo duas abordagens viáveis apontando prós, contras e riscos.
4. **Registro de Decisão Arquitetural (ADR):**
   - Formatar no padrão ADR: Status, Contexto, Decisão, Consequências (Positivas e Negativas).
