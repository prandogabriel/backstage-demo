# [Backstage](https://backstage.io)

This is your newly scaffolded Backstage App, Good Luck!

To start the app, run:

```sh
yarn install
yarn dev
```


# Deploy to local K8S

Config files is available on `kubernetes` folder

### Create namespace
kubectl apply -f kubernetes/namespace.yaml

### Create postgressql on K8S	
kubectl apply -f kubernetes/postgres-secrets.yaml
kubectl apply -f kubernetes/postgres-storage.yaml
kubectl apply -f kubernetes/postgres.yaml

if your postgres pod is in init error status, try create path `/mnt/data` into each work of your cluster 
kubectl exec -it --namespace=backstage postgres-7c5fdb8c56-2s6d8 -- /bin/bash

### Create postgres service
kubectl apply -f kubernetes/postgres-service.yaml

### Create backstage app secrets
kubectl apply -f kubernetes/backstage-secrets.yaml
	
###  Build docker image
yarn build-image --tag backstage:1.0.0

### Load docker image into kind
kind load docker-image backstage:1.0.0

###	Apply app into K8S
kubectl apply -f kubernetes/backstage.yaml

### View logs
kubectl logs --namespace=backstage -f backstage-54bfcd6476-n2jkm -c backstage
 
###	Create service 
  kubectl apply -f kubernetes/backstage-service.yaml
###	Redirect to default por
  sudo kubectl port-forward --namespace=backstage svc/backstage 80:80