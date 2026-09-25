# Agent Core — Decision Making & Anti-Overengineering

Este módulo governa as heurísticas de tomada de decisão arquitetural e técnica, assegurando que soluções permaneçam simples, proporcionais e justificadas.

---

## 1. O Filtro de 5 Perguntas (Anti-Overengineering)

Antes de propor ou aprovar qualquer nova abstração, componente, padrão de projeto ou tecnologia, o agente deve responder rigorosamente a:

1. **Qual problema real e concreto isso resolve?**  
   *(Se a resposta for "flexibilidade futura para caso X aconteça", rejeite imediatamente)*.
2. **Qual é o custo operacional, cognitivo e de manutenção dessa solução?**  
   *(Mais classes, mais camadas, mais contratos, maior tempo de onboarding)*.
3. **Qual é o benefício mensurável obtido agora?**  
   *(Performance, desacoplamento real de equipes, isolamento de dependência externa instável)*.
4. **Existe uma alternativa mais simples que atenda aos requisitos atuais?**  
   *(Uma função direta em vez de uma Factory de Strategies; um monolito modular em vez de microservices)*.
5. **Isso é estritamente necessário agora (YAGNI)?**  
   *(Se a necessidade for incerta ou distante, adie a decisão)*.

---

## 2. Padrões Prematuros Proibidos sem Justificativa Rígida

É vetado introduzir sem demonstração explícita de necessidade no contexto do projeto:

* **Microservices**: Não quebrar sistemas monolíticos a menos que existam gargalos de escala de equipes independentes ou requisitos de implantação/infraestrutura isolados.
* **CQRS / Event Sourcing**: Não separar modelos de leitura e escrita a menos que a complexidade de consulta e volume de leitura/escrita justifiquem o custo de consistência eventual.
* **DDD Excessivo / Arquitetura Cebola Prematura**: Não criar 5 camadas de mapeamento de DTO/VO/Entity para CRUDs simples de baixa complexidade de domínio.
* **Design Patterns Desnecessários**: Não introduzir Strategy, Factory, Observer ou Decorator quando um bloco condicional simples ou função pura resolver o caso com menor carga cognitiva.

---

## 3. Matriz de Avaliação de Trade-offs

Toda recomendação arquitetural relevante deve explicitar os trade-offs envolvidos:

| Dimensão | Ganho (+) | Custo / Risco (-) |
| :--- | :--- | :--- |
| **Complexidade** | Isolamento de responsabilidade | Maior quantidade de arquivos e indireção |
| **Performance** | Cache / Assincronismo | Invalidação de cache, complexidade de concorrência |
| **Segurança** | Criptografia / Validação estrita | Latência adicional, overhead de processamento |
| **Manutenibilidade** | Modularização | Custo inicial de design e testes de integração |

---

## 4. Gestão de Dívida Técnica

Ao identificar atalhos ou código legado:
1. Classificar o impacto da dívida técnica (P0 a P3).
2. Se o atalho for aceito como decisão de curto prazo, exigir o registro formal de uma **ADR** ou **Learning Candidate** com plano de quitação.
3. Nunca normalizar más práticas sem documentação explícita do trade-off aceito.
