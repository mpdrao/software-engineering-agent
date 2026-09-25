# Skill: AWS Cloud Architecture & Security

---

## 1. Purpose
A skill **aws** audita e orienta o design de arquiteturas na nuvem **Amazon Web Services (AWS)** seguindo os pilares do **AWS Well-Architected Framework** (Excelência Operacional, Segurança, Confiabilidade, Eficiência de Performance e Otimização de Custos).

---

## 2. When to Use
* Durante o workflow `/architect` ou `/security` ao projetar ou revisar infraestrutura em nuvem.
* Ao auditar políticas de IAM, permissões de S3 e grupos de segurança (Security Groups).
* Ao desenhar integrações desacopladas com SQS, SNS, EventBridge, Lambda e DynamoDB/RDS.

---

## 3. Inputs
* Modelos de infraestrutura como código (Terraform, AWS CDK, CloudFormation, SAM).
* Arquivos de configuração de SDKs e clientes AWS na aplicação.

---

## 4. Required Context
* [SKILLS/architecture](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/architecture/SKILL.md) e [SKILLS/security](file:///C:/Users/mario/OneDrive/Área%20de%20Trabalho/agente-gemini/projetos/software-engineering-agent/SKILLS/security/SKILL.md).
* Padrões em `BRAIN/07-STACK/`.

---

## 5. Analysis Procedure
1. **Auditoria de IAM (Menor Privilégio)**:
   * As roles do IAM utilizam políticas com `Action: "*"` e `Resource: "*"` (permissões excessivas)?
   * O código da aplicação assume roles via IAM Roles for Service Accounts (IRSA) / ECS Task Roles ou tenta ler chaves de acesso estáticas?
2. **Segurança de Armazenamento (S3 & RDS)**:
   * Buckets S3 possuem *Block Public Access* ativado e criptografia em repouso (SSE-S3 / SSE-KMS)?
   * Bancos de dados relacionais (RDS/Aurora) estão isolados em sub-redes privadas sem IP público?
3. **Resiliência & Redundância**:
   * O sistema está distribuído em múltiplas Zonas de Disponibilidade (Multi-AZ)?
   * Filas SQS possuem Dead Letter Queues (DLQ) configuradas para capturar mensagens venenosas (*poison pills*)?
4. **Otimização de Custos**:
   * Recursos ociosos ou superdimensionados (ex.: instâncias provisionadas sem autoscaling)?
   * Estratégias adequadas de lifecycle em buckets S3 (migração para Glacier).

---

## 6. Rules
* **R1 — Proibição de Permissões Estrela (Action: *)**: Políticas de IAM em produção não devem conter coringas descontrolados em ações administrativas.
* **R2 — RDS Sem IP Público**: Instâncias de banco de dados transacional nunca devem possuir endpoint acessível diretamente pela internet aberta.
* **R3 — Filas com DLQ Obrigatória**: Todo consumidor de mensagens em lote (SQS/EventBridge) deve possuir política de redrive para DLQ.

---

## 7. Anti-Patterns
* **Static Access Keys in Code**: Utilizar `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` dentro do código em vez de IAM Roles gerenciadas.
* **Public S3 Buckets for Internal Data**: Esquecer de ativar o bloqueio de acesso público em buckets contendo dados corporativos.
* **Database in Public Subnet**: Provisionar RDS em sub-rede pública com Security Group liberado para `0.0.0.0/0`.

---

## 8. Output Format

```markdown
# AWS Architecture & Security Audit: [Infraestrutura]

## Well-Architected Evaluation
* Segurança (IAM & Network): Conforme / Alerta de Permissões Excessivas
* Resiliência (Multi-AZ / DLQ): Adequada / Pontos Únicos de Falha
* Criptografia em Repouso: Habilitada / Ausente

## Findings
* **[P0 - BLOCKER] S3 Bucket Sem Bloqueio Público**:
  * **Arquivo**: `terraform/s3.tf#L12`
  * **Problema**: `block_public_acls = false` em bucket com documentos de clientes.
  * **Solução**: Ativar `aws_s3_bucket_public_access_block` restritivo.
```

---

## 9. Examples
* **Caso**: O Security Group do banco PostgreSQL permite tráfego de entrada na porta 5432 vindo de `0.0.0.0/0`.
* **Veredito**: `P0 - BLOCKER`.
* **Ação**: Restringir o tráfego exclusivamente para o Security Group das instâncias de aplicação backend.
