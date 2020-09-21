docker build -t maxfnine/multi-client:latest -t maxfnine/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maxfnine/multi-server:latest -t maxfnine/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maxfnine/multi-worker:latest -t maxfnine/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push maxfnine/multi-client:latest
docker push maxfnine/multi-server:latest
docker push maxfnine/multi-worker:latest
docker push maxfnine/multi-client:$SHA
docker push maxfnine/multi-server:$SHA
docker push maxfnine/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maxfnine/multi-server:$SHA
kubectl set image deployments/client-deployment server=maxfnine/multi-client:$SHA
kubectl set image deployments/worker-deployment server=maxfnine/multi-worker:$SHA