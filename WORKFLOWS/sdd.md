# Workflow: /sdd

---

## 1. Objetivo
Executar a verificação formal de conformidade entre a especificação funcional/técnica de um requisito, a implementação no código-fonte e a cobertura por testes automatizados, detectando divergências ou funcionalidades não implementadas.

---

## 2. Skills Utilizadas
* [SKILLS/sdd](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/sdd/SKILL.md)
* [SKILLS/testing](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/testing/SKILL.md)
* [SKILLS/architecture](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/architecture/SKILL.md)

---

## 3. Arquivos Consultados
* `PROJECTS/<projeto>/specification/` (`SPEC-XXX.md`, `REQ-XXX.md`).
* Código-fonte de controladores, serviços e repositórios da funcionalidade.
* Classes de teste unitário e de integração associadas.

---

## 4. Sequência de Análise
1. **Leitura e Extração de Critérios**: Parsear todos os cenários da especificação (requisitos funcionais, regras de negócio e limites de aceitação).
2. **Varredura de Implementação**: Para cada critério, localizar o arquivo e intervalo de linhas exatos onde a regra é executada.
3. **Varredura de Testes**: Localizar o método de teste específico que assevera o comportamento esperado para cada critério.
4. **Classificação Determinística**:
   * Marcar individualmente como `CONFORME`, `PARCIALMENTE_CONFORME`, `DIVERGENTE`, `NÃO_IMPLEMENTADO` ou `NÃO_VERIFICÁVEL`.
5. **Auditoria de Regras Não Documentadas**: Identificar no código ramificações condicionais ou regras de negócio que não foram previstas na especificação.

---

## 5. Formato da Saída
* Tabela de Rastreabilidade SDD.
* Seção de Divergências Críticas e Requisitos Ausentes.
* Veredito de Conformidade (`APROVADO_SDD` | `REPROVADO_SDD`).

---

## 6. Condições de Sucesso
* 100% dos critérios da especificação categorizados.
* Divergências apontadas com severidade apropriada (P1 para desvios de regra de negócio).
