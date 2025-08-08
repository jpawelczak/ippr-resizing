# In-place Pod Resize in Action

This demo shows few pod in-place resizing events on GCP's Kubernetes Engine, Standard Cluster:
* Pod with Guaranteed QoS
* Pod with Burstable QoS

# In-place Pod Resize on GKE Standard Cluster
Clone the repo, create a GKE Standard Cluster and:

```
kubectl apply -f ./manifests
./resize-guaranteed.sh
./resize-burstable.sh
kubectl get pods
kubectl delete -f ./manifests
```

Check how the requests and limits changed on GCP's Console -> GKE -> Workloads -> Pods and click a pod.
