#!/bin/sh

# kubectl apply -f ./manifests

echo "starting ippr demo for Guaranteed pod"
echo ""

sleep 1s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"2G"},"limits":{"memory":"2G"}}}]}}' \
  && echo "scale-up mem to 2G"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.5"},"limits":{"cpu":"0.5"}}}]}}' \
  && echo "scale-down CPU to 0.5"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"1.5"},"limits":{"cpu":"1.5"}}}]}}' \
  && echo "scale-up CPU to 1.5"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"3G"},"limits":{"memory":"3G"}}}]}}' \
  && echo "scale-up mem to 3G"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"1"},"limits":{"cpu":"1"}}}]}}' \
  && echo "scale-down CPU to 1"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.250"},"limits":{"cpu":"0.250"}}}]}}' \
  && echo "scale-down CPU to 0.250"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"1.5","memory":"4G"},"limits":{"cpu":"1.5","memory":"4G"}}}]}}' \
  && echo "scale-up CPU to 1.5 and mem to 4G"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.250"},"limits":{"cpu":"2"}}}]}}' \
  && echo "change QoS from Guaranteed to Burstable = operation not supported"

echo ""
sleep 55s

kubectl patch pod resize-demo-g --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"28G"},"limits":{"memory":"28G"}}}]}}' \
  && echo "scale-up to massive 28G Mem... no capacity on the node...?" \
  && echo "...?" \
  && echo "Run 'kubectl get pod resize-demo-g -o yaml' and check 'status' (infeasible) section for message"

echo ""
sleep 1s
echo "Now run 'kubectl get pods' to check how often Pods were restarted (should be 0)"

# kubectl get pods
# kubectl delete -f ./manifests/