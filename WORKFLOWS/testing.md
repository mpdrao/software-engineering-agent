# Workflow: /test

---

## 1. Objetivo
Avaliar a maturidade, determinismo, cobertura semântica e eficácia da suíte de testes automatizados de um projeto ou módulo, identificando lacunas de casos de borda e testes frágeis (*flaky*).

---

## 2. Skills Utilizadas
* [SKILLS/testing](../SKILLS/testing/SKILL.md)
* [SKILLS/sdd](../SKILLS/sdd/SKILL.md)

---

## 3. Arquivos Consultados
* Diretórios de teste (`src/test/...`, `tests/`, `spec/`).
* Configurações de frameworks e fixtures de teste.
* Classes de negócio sob teste correspondentes.

---

## 4. Sequência de Análise
1. **Mapeamento da Pirâmide de Testes**: Quantificar e classificar a proporção de testes unitários, testes de integração e testes e2e.
2. **Auditoria de Asserções**: Verificar se os testes validam estado e efeitos colaterais reais ou se contêm asserções fracas/ausentes.
3. **Detecção de Mock Overdose**: Identificar testes onde o excesso de mocks torna o teste inútil para capturar falhas reais.
4. **Verificação de Determinismo**: Checar dependências temporais (`Thread.sleep`), ordem de execução e chamadas externas desprotegidas.
5. **Varredura de Casos de Borda**: Checar ausência de testes para valores nulos, coleções vazias, payloads volumosos e timeouts.

---

## 5. Formato da Saída
* Diagnóstico da Pirâmide de Testes.
* Lista de testes vulneráveis ou viciados.
* Recomendações de novos cenários de teste essenciais.

---

## 6. Condições de Sucesso
* Testes auditados quanto ao determinismo e cobertura semântica.
* Apresentação de exemplos concretos de testes ausentes com código AAA.
