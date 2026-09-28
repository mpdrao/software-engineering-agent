---
name: sdd
description: >-
  Audita a rastreabilidade entre requisitos de negócio, especificações formais, contratos de API e a implementação no código e testes. Use esta skill quando o usuário digitar /sdd ou solicitar validação de especificação (Specification Driven Development).
---

# Skill: /sdd — Specification Driven Development

Verifica a conformidade rigorosa da base de código e da suíte de testes contra as especificações e contratos documentados.

---

## 1. Parâmetros de Entrada

Ao receber `/sdd [argumentos]`, extraia:
- `spec`: Arquivo de especificação (`SPEC-XXX.md`, `openapi.yaml`, ou `REQ-XXX.md`).
- `target`: Classe, serviço ou endpoint sob auditoria.
- `tests` *(opcional)*: Classe ou diretório de testes correspondente.

Se o usuário invocar `/sdd` sem parâmetros específicos em um projeto, procure especificações ativas em `PROJECTS/<projeto>/specification/` ou na raiz do repositório.

---

## 2. Protocolo de Execução

1. **Extração de Requisitos e Critérios de Aceite:**
   - Listar todos os critérios de negócio da especificação com IDs únicos (ex: `AC-01`, `AC-02`).
2. **Inspeção de Contratos de API:**
   - Validar se rotas, verbos HTTP, parâmetros de consulta, status codes e payloads JSON atendem ao contrato.
3. **Mapeamento no Código de Domínio:**
   - Verificar se as regras de validação, fluxos de exceção e cálculos descritos na especificação estão implementados.
4. **Verificação da Suíte de Testes:**
   - Confirmar se existe ao menos um caso de teste cobrindo cada critério de aceite (caminho feliz e casos de erro).
5. **Matriz de Rastreabilidade:**
   Classificar cada critério de aceite em uma das categorias:
   - `CONFORME`: Implementado no código e coberto por asserções em testes.
   - `PARCIALMENTE_CONFORME`: Implementado, mas sem teste ou com asserções insuficientes.
   - `DIVERGENTE`: Código implementa comportamento diferente do especificado.
   - `NÃO_IMPLEMENTADO`: Requisito ausente no código.

---

## 3. Saída Gerada

Apresentar a Matriz de Conformidade em tabela Markdown, listar as divergências encontradas com referência de arquivo e linha, e prescrever os ajustes ou testes ausentes.
