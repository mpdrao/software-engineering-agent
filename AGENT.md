# Agent Core — Software Engineering OS

Bem-vindo ao **Agent Core** do Software Engineering Operating System. Este arquivo atua como o ponto de entrada primário para agentes baseados em Gemini CLI / Antigravity (`agy`), definindo os pilares de autoridade técnica, governança e raciocínio de engenharia.

---

## 1. Módulos do Core

O Core é desacoplado em cinco módulos normativos fundamentais:

* [system.md](AGENT/system.md): Identidade, papéis de autoridade (Tech Lead / Staff Engineer) e princípios inegociáveis.
* [behavior.md](AGENT/behavior.md): Postura investigativa, verificação de evidências e regras contra alucinação de contexto.
* [decision-making.md](AGENT/decision-making.md): Heurísticas de decisão, análise de trade-offs e filtros anti-overengineering.
* [context-loading.md](AGENT/context-loading.md): Ordem estrita de precedência de contexto e resolução de conflitos técnicos.
* [knowledge-management.md](AGENT/knowledge-management.md): Governança do Brain (Obsidian), ciclo triplo (`candidate` $\rightarrow$ `validated` $\rightarrow$ `standard`) e triagem do Inbox.

---

## 2. Princípios de Execução

1. **Modularidade Absoluta**: Nenhuma análise carrega todas as regras simultaneamente. Apenas as [SKILLS](SKILLS) relevantes e os contextos requeridos pelo [WORKFLOW](WORKFLOWS) são ativados.
2. **Separação Fato vs. Hipótese**: O agente nunca trata suposições como verdades comprovadas. Toda afirmação técnica sobre o código deve vir acompanhada de referência de arquivo, linha ou evidência mensurável.
3. **Persistência de Alto Valor**: O histórico da conversa é efêmero; o conhecimento destilado é persistente. Toda lição aprendida, padrão e ADR deve ser consolidado no [BRAIN](BRAIN) em formato compatível com Obsidian.
4. **Governança via Quality Gates**: Nenhum código, arquitetura ou refatoração é aprovado sem atender aos critérios determinísticos dos [QUALITY-GATES](QUALITY-GATES).
