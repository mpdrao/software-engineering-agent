---
name: test
description: >-
  Audita a integridade da suíte de testes, proporção da pirâmide, qualidade semântica das asserções e ausência de testes tautológicos ou não determinísticos. Use esta skill quando o usuário digitar /test ou solicitar diagnóstico da suíte de testes.
---

# Skill: /test — Diagnóstico da Suíte de Testes

Avalia se os testes automatizados são confiáveis, mantêm cobertura semântica real e protegem o sistema contra regressões sem criar acoplamento com detalhes de implementação.

---

## 1. Parâmetros de Entrada

Ao receber `/test [argumentos]`, extraia:
- `test_target`: Pasta de testes ou arquivo específico de teste. Se omitido, busque as suítes de teste padrão do projeto.

---

## 2. Critérios de Auditoria de Testes

1. **Equilíbrio da Pirâmide:**
   - Proporção adequada entre testes unitários rápidos, testes de integração de componentes/banco e testes ponta-a-ponta (E2E).
2. **Qualidade Semântica das Asserções:**
   - Detecção de testes sem asserção (`assertNotNull` em tudo ou métodos vazios).
   - Testes que apenas verificam se a chamada rodou sem lançar exception, sem validar o estado resultante.
3. **Mocks e Acoplamento Indevido:**
   - Uso excessivo de mocks em testes unitários que acabam testando a implementação interna em vez do contrato observável.
4. **Determinismo e Isolamento:**
   - Ausência de dependência de ordem de execução entre testes.
   - Limpeza adequada de estado e dados de teste (fixtures limpas).

---

## 3. Saída Gerada

- Diagnóstico da pirâmide de testes do projeto.
- Lista de testes viciados, frágeis ou tautológicos encontrados.
- Exemplos de refatoração para asserções semânticas robustas.
