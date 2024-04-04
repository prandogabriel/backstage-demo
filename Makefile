create-all:
	kubectl apply -f kubernetes/namespace.yaml
	kubectl apply -f kubernetes/postgres-secrets.yaml
	kubectl apply -f kubernetes/postgres-storage.yaml
	kubectl apply -f kubernetes/postgres.yaml
	# kubectl exec -it --namespace=backstage postgres-7c5fdb8c56-2s6d8 -- /bin/bash
	kubectl apply -f kubernetes/postgres-service.yaml
	kubectl apply -f kubernetes/backstage-secrets.yaml
	yarn build-image --tag backstage:1.0.0
	kubectl apply -f kubernetes/backstage.yaml
	# kubectl logs --namespace=backstage -f backstage-54bfcd6476-n2jkm -c backstage
	kubectl apply -f kubernetes/backstage-service.yaml
	sudo kubectl port-forward --namespace=backstage svc/backstage 80:80