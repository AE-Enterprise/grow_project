# Build and push the plants image to k8s.io namespace for Rancher Desktop
nerdctl --namespace k8s.io build -t plants:latest .