# TODO

2. Serviço não exposto corretamente
Descrição: Um Service do tipo NodePort não expõe a aplicação.
Configuração:
Configure um Deployment com uma aplicação que serve em uma porta diferente da configurada no Service.
Objetivo: Diagnosticar e corrigir a porta exposta no Service.

4. PersistentVolume não ligado ao PersistentVolumeClaim
Descrição: Um PVC não consegue se conectar ao PV devido a incompatibilidades.
Configuração:
Configure um PVC e PV com tamanhos diferentes ou labels incorretos.
Objetivo: Ajustar as definições para garantir o binding correto.

5. Problemas de toleration e taint
Descrição: Um Pod não agenda em nenhum nó devido a taints.
Configuração:
Aplique um taint em um nó e configure um Pod sem o toleration correspondente.
Objetivo: Diagnosticar o problema e adicionar o toleration necessário.


 Node não está pronto
Descrição: Um ou mais nós estão no estado NotReady.
Configuração:
Simule um problema desabilitando um serviço essencial como kubelet ou preenchendo o disco.
Objetivo: Diagnosticar e trazer os nós de volta ao estado Ready.

