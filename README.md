# TODO


2. Configuração de Auto-Scaling Horizontal de Pods (HPA)
Objetivo: Criar um Horizontal Pod Autoscaler (HPA) que ajuste automaticamente o número de réplicas do seu deployment com base na carga de CPU.
Tarefa:
Crie um deployment simples.
Configure um HPA para escalar os pods baseado no uso de CPU.
Realize uma carga no serviço e observe o aumento no número de pods.
3. Gerenciamento de StatefulSets com Persistência
Objetivo: Criar um StatefulSet que utilize Persistent Volumes (PVs) para armazenamento persistente e configure uma rede de pods com identidade única.
Tarefa:
Crie um StatefulSet com pelo menos 3 pods.
Crie PersistentVolumeClaims (PVCs) para garantir a persistência de dados.
Acesse os pods e verifique a persistência após reiniciar os pods.
4. Gerenciamento de Segredos com Secrets e ConfigMaps
Objetivo: Criar e acessar Secrets e ConfigMaps em um pod de forma segura. Demonstrar o uso dessas informações para configurar uma aplicação.
Tarefa:
Crie um Secret para armazenar informações sensíveis como credenciais de banco de dados.
Crie um ConfigMap para armazenar configurações não sensíveis.
Monte os Secrets e ConfigMaps como variáveis de ambiente ou volumes em um pod.
5. Política de Rede e Isolation (Network Policies)
Objetivo: Criar políticas de rede para isolar pods entre namespaces e controlar a comunicação entre eles.
Tarefa:
Crie dois namespaces (ex: frontend e backend).
Crie pods dentro desses namespaces e configure uma política de rede para bloquear o tráfego entre eles.
Teste o isolamento de rede entre os pods.
6. Rollout de Atualizações e Rollbacks de Deployments
Objetivo: Criar um deployment com várias versões e realizar atualizações, monitorando o processo de rollout. Simular um rollback em caso de falha.
Tarefa:







