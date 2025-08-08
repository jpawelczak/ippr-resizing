#!/bin/sh

# kubectl apply -f ./manifests

echo "starting ippr demo for Burstable pod"
echo ""

sleep 2s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"1G"},"limits":{"memory":"2G"}}}]}}' \
  && echo "scale-up mem limit to 2G"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.5"},"limits":{"cpu":"1.5"}}}]}}' \
  && echo "scale-down CPU request to 0.5"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"1.5"},"limits":{"cpu":"2.5"}}}]}}' \
  && echo "scale-up CPU to 1.5 & 2.5"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"1G"},"limits":{"memory":"3G"}}}]}}' \
  && echo "scale-up mem limit to 3G"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.1"},"limits":{"cpu":"4"}}}]}}' \
  && echo "Scale down CPU request to 0.1 and scale-up CPU limit to 4"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"0.250"},"limits":{"cpu":"1"}}}]}}' \
  && echo "scale-down CPU req to 0.250 and limit to 1"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"1.5","memory":"0.5G"},"limits":{"cpu":"1.5","memory":"4G"}}}]}}' \
  && echo "scale-up CPU to 1.5 and mem to 4G"

echo ""
sleep 55s

kubectl patch pod resize-demo-be --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"2"},"limits":{"cpu":"2"}}}]}}' \
  && echo "scale-up CPU requests and limits to 2. Mem: 0.5 and 4 = Burstable QoS"

echo ""
echo "Now run 'kubectl get pods' to check how often Pods were restarted (should be 0)"

# kubectl get pods
# kubectl delete -f ./manifests/