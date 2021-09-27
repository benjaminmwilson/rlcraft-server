
```shell
docker build . -t bmwilson74/rlcraft-server
docker run -v $(pwd)/data:/data -ti bmwilson74/rlcraft-server
```

https://medium.com/google-cloud/kubernetes-110-your-first-deployment-bf123c1d3f8
https://medium.com/google-cloud/kubernetes-120-networking-basics-3b903f13093a

```shell
gcloud auth login
# project name must be unique and never have existed
gcloud projects create game-servers-202109211806 --name="Game Servers"
gcloud config set project game-servers-202109211806
gcloud beta billing accounts list
# using  billing account id from accounts list
gcloud beta billing projects link game-servers-202109211806 --billing-account=XXXX
gcloud services list --available
# enable kubernetes
gcloud services enable container.googleapis.com
gcloud container clusters create game-servers-cluster --zone us-west1-a
gcloud container node-pools create game-servers-pool  --zone us-west1-a --cluster game-servers-cluster --machine-type e2-standard-2 --num-nodes 1

# adds to ~/.kube/config
gcloud container clusters get-credentials game-servers-cluster --zone us-west1-a

#create new default pool and migrate to it
# done better at https://cloud.google.com/kubernetes-engine/docs/tutorials/migrating-node-pool
gcloud container node-pools create def-pool --cluster game-servers-cluster --machine-type e2-medium --num-nodes 3 --disk-size 10 --zone us-west1-a
gcloud container clusters resize game-servers-cluster --node-pool default-pool --num-nodes 0  --zone us-west1-a
```

```shell
kubectl apply -f deploy.yaml
```