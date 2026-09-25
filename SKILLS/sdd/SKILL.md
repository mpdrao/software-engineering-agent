# Skill: Specification Driven Development (SDD)

---

## 1. Purpose
A skill **sdd** audita, valida e garante a rastreabilidade bidirecional estrita entre os requisitos de negócio, especificações técnicas, código-fonte implementado e testes automatizados. Seu objetivo principal é eliminar desvios funcionais (*feature drift*) e garantir que nenhuma linha de lógica de negócio exista sem especificação prévia ou sem validação correspondente.

---

## 2. When to Use
* Quando uma nova funcionalidade for implementada e precisar ser validada contra a especificação original.
* Durante o workflow `/sdd` ou como etapa inicial do workflow `/audit`.
* Ao receber um PR para validar se os critérios de aceitação foram cumpridos integralmente.
* Para identificar código morto, regras não documentadas ou testes ausentes.

---

## 3. Inputs
* **Especificação / Requisitos**: Arquivos em `PROJECTS/<projeto>/specification/` ou documentos de requisitos (`REQ-XXX`, `SPEC-XXX`).
* **Código-Fonte**: Classes de serviço, controladores, agregados de domínio e componentes de interface.
* **Testes Automatizados**: Suítes de testes unitários, testes de integração e testes e2e correspondentes.

---

## 4. Required Context
* Regras de precedência do projeto ([context-loading.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/context-loading.md)).
* Padrões de especificação ([TEMPLATES/specification.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/specification.md) e [TEMPLATES/requirement.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/TEMPLATES/requirement.md)).

---

## 5. Analysis Procedure

O procedimento segue a cadeia tripla:
$$\text{Requirement} \longrightarrow \text{Implementation} \longrightarrow \text{Test}$$

1. **Extração de Requisitos**: Listar todos os critérios de aceitação atômicos e cenários (Happy Path e Edge Cases) da especificação.
2. **Localização no Código**: Mapear para cada critério qual método, classe ou módulo é responsável por executá-lo.
3. **Localização nos Testes**: Mapear para cada critério qual método de teste automatizado assegura sua asserção.
4. **Classificação da Rastreabilidade**: Atribuir a cada item uma das cinco classificações normativas:
   * `CONFORME`: Implementação e teste cobrem o requisito com exatidão.
   * `PARCIALMENTE_CONFORME`: Implementação existe, mas omite cenários de borda ou testes adequados.
   * `DIVERGENTE`: O código faz algo substancialmente diferente do que a especificação determinou.
   * `NÃO_IMPLEMENTADO`: O requisito está na especificação, mas inexiste código-fonte correspondente.
   * `NÃO_VERIFICÁVEL`: O requisito é vago, genérico ou impossível de testar deterministamente.

---

## 6. Rules
* **R1 — Proibição de Premissas Ocultas**: Se o código implementa validações ou fluxos que não constam na especificação, sinalize como "Regra Não Documentada" para atualização da spec ou remoção.
* **R2 — Cobertura de Cenários Negativos**: Um requisito só é `CONFORME` se possuir testes tanto para o caminho de sucesso quanto para cenários de rejeição/exceção.
* **R3 — Evidência Explícita**: Todo apontamento deve citar o arquivo e linha exatos da regra e do teste.

---

## 7. Anti-Patterns
* **Code First, Spec Never**: Desenvolver a solução inteira e escrever uma especificação cosmética a posteriori sem rigor.
* **Vague Acceptance Criteria**: Requisitos sem critérios objetivos verificáveis (ex.: "o sistema deve ser rápido e intuitivo").
* **Untested Happy-Path-Only**: Testar apenas o cenário com entradas perfeitas, ignorando timeouts, entradas nulas ou valores limítrofes.

---

## 8. Output Format

```markdown
# SDD Verification Report: [Funcionalidade / Módulo]

## Summary Matrix
| Requisito ID | Cenário / Regra | Implementação | Teste Automatizado | Status SDD |
| :--- | :--- | :--- | :--- | :---: |
| REQ-001.1 | Criação com dados válidos | `OrderService.java#L32` | `OrderServiceTest.java#L40` | `CONFORME` |
| REQ-001.2 | Rejeição por estoque zero | `OrderService.java#L55` | *Ausente* | `PARCIALMENTE_CONFORME` |

## Divergences & Missing Implementations
* **REQ-001.2**: Falta teste unitário simulando estoque nulo.
```

---

## 9. Examples

### Exemplo de Análise
* **Especificação**: *"REQ-042: O desconto não pode ultrapassar 30% do valor total da fatura."*
* **Código Analisado**: `if (discount > invoice.getTotal() * 0.50) throw new IllegalArgumentException();`
* **Veredito**: `DIVERGENTE`.
* **Finding Gerado**:
  * Severidade: `P1 - CRITICAL`
  * Localização: `InvoiceService.java#L78`
  * Problema: Código permite desconto de até 50%, violando o limite de 30% estipulado na especificação REQ-042.
