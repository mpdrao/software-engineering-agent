---
name: analyze
description: >-
  Executa investigação diagnóstica aprofundada em um arquivo, classe ou módulo específico, mapeando dependências, acoplamento, complexidade e responsabilidades. Use esta skill quando o usuário digitar /analyze ou solicitar análise diagnóstica direcionada.
---

# Skill: /analyze — Investigação Técnica Sob Demanda

Realiza análise cirúrgica de uma unidade de código para responder dúvidas de design, dependências e qualidade interna.

---

## 1. Parâmetros de Entrada

Ao receber `/analyze [argumentos]`, extraia:
- `target`: Caminho do arquivo, classe ou pacote a ser diagnosticado.
- `focus` *(opcional)*: `all` (padrão), `solid`, `clean-code`, `complexity` ou `architecture`.

---

## 2. Protocolo de Diagnóstico

1. **Mapeamento Estrutural:**
   - Inventariar métodos públicos, estado interno mutável e dependências injetadas.
2. **Avaliação de Coesão e Acoplamento:**
   - Quantificar acoplamento aferente (quantos dependem dele) e eferente (de quantos ele depende).
   - Identificar dependência de tipos concretos vs abstrações (interfaces/ports).
3. **Métricas de Complexidade:**
   - Contar pontos de decisão (if/else, switch, loops) e profundidade de aninhamento.
4. **Smells e Riscos Detectados:**
   - God Class, Feature Envy, Long Method, Primitive Obsession.

---

## 3. Saída Gerada

- Diagrama ou resumo de dependências da unidade analisada.
- Lista de violações identificadas com nível de severidade.
- Recomendações arquiteturais e de refatoração priorizadas.
