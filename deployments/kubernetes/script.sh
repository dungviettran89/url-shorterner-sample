#!/bin/bash
kubectl create -n url-shortener deployment backend --image=dungviettran89/url-shortener-backend-java-spring:latest
kubectl set env -n url-shortener deployment/backend DB_HOST=mariadb DB_PASS=urlshortener
kubectl scale -n url-shortener deployment/backend --replicas=2
kubectl expose -n url-shortener deployment/backend --port=8080 --target-port=8000

kubectl get -n url-shortener deployment/backend service/backend -o yaml |\
 sed -e '/uid/d' |\
 tee backend.yaml

kubectl create -n url-shortener deployment frontend \
  --image=dungviettran89/url-shortener-frontend-react:latest \
  --dry-run=client -o yaml \
  > frontend.yaml

kubectl apply -n url-shortener --force -f frontend.yaml

kubectl -n url-shortener get deployment/mariadb -o yaml | tee final/mariadb.yaml
kubectl -n url-shortener get deployment/backend service/backend -o yaml | tee final/backend.yaml
kubectl -n url-shortener get deployment/frontend service/frontend ingress/frontend -o yaml | tee final/backend.yaml
