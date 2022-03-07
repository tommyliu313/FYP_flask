這裏暫時預備要執行的command.
當預備充足才執行。

# Script from Deploy an Application by Using Azure Kubernetes Service Guided
```bash
az aks get-credentials --resource-group [resourrcegroupname] --name [name]
kubectl get node
kubectl create deployment nginx-xxxxxxxx --image=nginx
kubectl expose deplyment nginx-xxxxxxxx --port=80 --type=LoadBalancer
```