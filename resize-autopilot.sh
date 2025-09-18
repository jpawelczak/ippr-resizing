#!/bin/sh

# kubectl apply -f ./manifests

echo "starting ippr demo for Guaranteed Pod (1 CPU & 1GiB Mem) on Autopilot Cluster"
echo ""

sleep 1s

echo "Let's start from scale-up CPU req and limits to 1.5 to get pod with 1.5 CPU & 1 GiB Mem" 
echo ""
kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"1.5"},"limits":{"cpu":"1.5"}}}]}}' \
  && echo "scale-up CPU req and limits to 1.5"

echo ""
echo "Error: the resize was blocked as Autopilot accepts CPU:Mem ratio between 1:1 and 1:6.5"
echo ""

sleep 1s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"2G"},"limits":{"memory":"2G"}}}]}}' \
  && echo "scale-up Mem req and limits to 2G"

echo ""
sleep 5s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"1G"},"limits":{"memory":"1G"}}}]}}' \
  && echo "scale-down Mem req and limits back to 1G"

echo ""
echo "Note: IPPR supports in-place Mem scale-down supported starting from GKE 1.34"
echo ""

sleep 5s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.5"},"limits":{"cpu":"0.5"}}}]}}' \
  && echo "scale-down CPU req and limits to 0.5"

echo ""
sleep 5s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.250","memory":"0.250G"},"limits":{"cpu":"0.250","memory":"0.250G"}}}]}}' \
  && echo "scale-down to 0.250 CPU and to 0.250G Mem"

echo ""
sleep 5s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.5","memory":"4G"},"limits":{"cpu":"0.5","memory":"4G"}}}]}}' \
  && echo "scale-up CPU to 0.5 and mem to 4G"

echo ""
echo "Error: the resize was blocked as Autopilot accepts CPU:Mem ratio between 1:1 and 1:6.5"
sleep 1s
echo "Now run 'kubectl get pods' to check how often Pods were restarted (should be 0)"

# kubectl get pods
# kubectl delete -f ./manifests/