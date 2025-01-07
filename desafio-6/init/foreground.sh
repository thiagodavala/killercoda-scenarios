FILE=/ks/wait-init.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}

NAMESPACE="kube-system"
PODS=$(kubectl get pods -n $NAMESPACE -l k8s-app=kube-dns -o jsonpath='{.items[*].metadata.name}')
for POD in $PODS; do
  kubectl exec -it $POD -n $NAMESPACE -- tc qdisc add dev eth0 root netem loss 50%
done