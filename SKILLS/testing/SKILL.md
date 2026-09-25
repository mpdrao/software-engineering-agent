# Skill: Testing Strategy & Verification

---

## 1. Purpose
A skill **testing** audita a qualidade, determinismo, eficácia e cobertura da estratégia de testes automatizados do projeto. Ela assegura que a suíte de testes atue como uma verdadeira rede de segurança para refatoração e evolução contínua, prevenindo regressões, avaliando a pirâmide de testes e combatendo testes frágeis ou viciados (*flaky tests*).

---

## 2. When to Use
* Durante o workflow `/test` ou na etapa de testes do `/audit`.
* Ao avaliar PRs para verificar se novos cenários foram adequadamente testados.
* Ao identificar testes instáveis (*flaky*), lentos ou que testam detalhes de implementação em vez de comportamento.

---

## 3. Inputs
* Arquivos de teste unitário, integração, contrato e e2e (`src/test/...`).
* Configurações de frameworks de teste (JUnit, Jest, PyTest, Testcontainers, Mockito).
* Relatórios de cobertura de código (JaCoCo, Istanbul/NYC, etc.) se disponíveis.

---

## 4. Required Context
* [AGENT/system.md](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/AGENT/system.md) (Testabilidade como princípio inegociável).
* Diretrizes em `BRAIN/05-TESTING/`.

---

## 5. Analysis Procedure

1. **Avaliação da Pirâmide de Testes**:
   * O projeto possui uma base sólida e rápida de testes unitários isolados?
   * Os testes de integração são direcionados para verificar fronteiras reais (banco de dados, mensageria via Testcontainers)?
   * Há excesso de testes ponta a ponta (e2e) lentos e instáveis compensando a ausência de testes de unidade?
2. **Qualidade das Asserções (Assertions)**:
   * Existem testes sem asserção ou apenas chamando o método sem validar o retorno (*assert-free tests*)?
   * As asserções validam o estado final ou efeito colateral esperado com precisão semântica?
3. **Uso de Dublês e Mocks**:
   * O código sofre de *Mock Overdose* (mocking de mais de 3-4 dependências onde a maioria não é necessária)?
   * O teste está validando comportamento real ou apenas espelhando linha por linha o código de produção?
4. **Isolamento e Determinismo**:
   * Os testes dependem de ordem de execução ou de dados compartilhados no banco sem limpeza?
   * O teste faz chamadas para serviços externos reais na internet (gerando falhas aleatórias por instabilidade de rede)?
5. **Cobertura de Casos de Borda**:
   * Listas vazias, valores nulos, strings longas, números negativos, timestamps em fuso-horários diferentes são testados?

---

## 6. Rules
* **R1 — Testes Devem Ser Determinísticos**: Um teste que passa em uma execução e falha em outra sem mudança de código é uma falha de design inaceitável.
* **R2 — Testar Comportamento, Não Implementação**: Refatorar um método privado sem alterar a saída pública não deve quebrar testes.
* **R3 — Padrão AAA**: Todos os testes devem seguir a estrutura visual e lógica **Arrange, Act, Assert** (Dado, Quando, Então).

---

## 7. Anti-Patterns
* **The Liar Test**: Teste que passa com sucesso mesmo quando o componente principal está quebrado (ex.: asserção `assertTrue(true)` no bloco catch).
* **Mock Mock Mock**: Mockar classes de domínio, estruturas de dados puras ou utilitários simples.
* **Sleep-Driven Testing**: Usar `Thread.sleep(5000)` para esperar respostas assíncronas em vez de mecanismos de polling ativo com timeout (ex.: Awaitility).

---

## 8. Output Format

```markdown
# Testing Strategy Audit: [Módulo / Suíte]

## Health Score
* Pirâmide de Testes: Adequada / Invertida (Ice Cream Cone)
* Determinismo: Alto / Risco de Flakiness
* Cobertura Semântica: Boa / Superficial

## Deficiências Críticas

### Teste Frágil por Mocking Excessivo
* **Arquivo**: `src/test/java/com/app/service/BillingTest.java#L80`
* **Problema**: O teste mocka até o objeto `Money` e `InvoiceItem`, verificando apenas se `mock.getValue()` foi chamado 2 vezes.
* **Recomendação**: Usar instâncias reais de Value Objects e testar o cálculo real da fatura.
```

---

## 9. Examples
* **Caso**: Um teste de integração faz chamada HTTP direta para a API de pagamentos em produção ou sandbox externo:
  `restTemplate.postForObject("https://api.stripe.com/v1/charges", ...)`
* **Veredito**: `P1 - CRITICAL`.
* **Ação**: Isolar chamadas externas em testes usando WireMock ou MockServer local.
