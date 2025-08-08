# In-place Pod Resize in Action
Starting from GKE 1.33, you can change the CPU and memory resource requests and limits assigned to a container without recreating the Pod using [In-Place Pod Resize feature (Beta / Public Preview)](https://github.com/kubernetes/enhancements/tree/master/keps/sig-node/1287-in-place-update-pod-resources).

This demo shows few pod in-place resizing events on GCP's Kubernetes Engine, Standard Cluster:
* Pod with Guaranteed QoS: `resize-demo-g`
* Pods with Burstable QoS: `resize-demo-be` (burstable CPU & Mem) and `resize-demo-no-limit` (no CPU limits)

Note: 
* `resizePolicy` is *not* set for in Pods for given resources - `PreferNoRestart` default setting is applied.
* It is *not* possible to scale down container's Mem Resource Limit, but you can scale down its Mem Resource Requests. 

Learn more about In-place Pod Resize in official [k8s documentation](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/)

## In-place Pod Resize on GKE Standard Cluster
Clone the repo, create a GKE Standard Cluster and do following:
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

## Patched successfully, but no changes?
If we resize a pod and there is no capacity on the node (eg patched resize-demo-g to 28G Mem), the patch will be successful, but pod's size remains the same. In this case, the pod resize will become "infeasable":
```
status:
  conditions:
  - lastProbeTime: "2025-08-08T13:29:58Z"
    lastTransitionTime: "2025-08-08T12:55:21Z"
    message: 'Node didn''t have enough capacity: memory, requested: 28000000000, capacity:
      13920960512'
    reason: Infeasible
    status: "True"
    type: PodResizePending
```

To check status of in-place pod resize, try this:
``` 
kubectl get pod resize-demo-g -o yaml
```
And check 'status' section in the pod like in the example above ([more about in-place resize statuses](https://github.com/kubernetes/enhancements/tree/master/keps/sig-node/1287-in-place-update-pod-resources#resize-status)).

## Cleanup
If you are done for today, you can remove the pods:

```
kubectl delete -f ./manifests
```
