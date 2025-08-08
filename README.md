# In-place Pod Resize in Action
Starting from GKE 1.33, you can change the CPU and memory resource requests and limits assigned to a container without recreating the Pod (Beta feature / Public Preview).

This demo shows few pod in-place resizing events on GCP's Kubernetes Engine, Standard Cluster:
* Pod with Guaranteed QoS
* Pod with Burstable QoS

Note: 
* `resizePolicy` is NOT set for in Pods for given resources - `PreferNoRestart` default setting is applied.
* Mind that it is not possible to scale down container's Mem Resource Limit, but you can scale down its Mem Resource Requests. 

Learn more about In-place Pod Resize in official [k8s documentation](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/)

# In-place Pod Resize on GKE Standard Cluster
Clone the repo, create a GKE Standard Cluster and:

```
kubectl apply -f ./manifests
./resize-guaranteed.sh
./resize-burstable.sh
```

Check how the requests and limits changed on GCP's Console -> GKE -> Workloads -> Pods and click a pod.

Now, check how often pods were restarted (should be 0 for the cases in the scripts)
```
kubectl get pods
```

Now, you can remove pods.

```
kubectl delete -f ./manifests
```
