#!/bin/sh

# kubectl apply -f ./manifests

echo "starting ippr demo for Guaranteed Pod (100m CPU & 125Mi Mem) on Autopilot Cluster"
echo ""

sleep 1s

echo ""
echo "Let's start from scaling down CPU and Mem even further"
echo ""

kubectl patch pod resize-demo-mini --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"50m","memory":"75Mi"},"limits":{"cpu":"50m","memory":"75Mi"}}}]}}' \
  && echo "scale-down to 50m CPU and to 75Mi Mem"

echo ""
echo "Note: IPPR supports in-place Mem scale-down supported starting from GKE 1.34"
echo ""

sleep 5s

kubectl patch pod resize-demo-mini --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"cpu":"40m"},"limits":{"cpu":"40m"}}}]}}'

echo ""
echo "Error: the resize was blocked - resize below Autopilot's CPU minimum"
echo ""

sleep 1s

kubectl patch pod resize-demo-mini --subresource resize --patch \
  '{"spec":{"containers":[{"name":"demo-g", "resources":{"requests":{"memory":"50Mi"},"limits":{"memory":"50Mi"}}}]}}'

echo ""
echo "Error: the resize was blocked - resize below Autopilot's Mem minimum"
echo ""

sleep 1s