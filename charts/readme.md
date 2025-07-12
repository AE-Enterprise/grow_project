# Install helm app.

helm install api-gateway ./charts/api-gateway -n grow

# Upgrade after first deployment

helm upgrade api-gateway ./charts/api-gateway -n grow


## Using GitHub Container Registry (GHCR) with Kubernetes

To pull private images from GHCR, you must create a Kubernetes secret with your GitHub Personal Access Token (PAT) and reference it in your Helm chart values as `imagePullSecrets:`

### 1. Create the Kubernetes Secret

Replace `<YOUR_GITHUB_USERNAME>`, `<YOUR_GITHUB_PAT>`, and `<YOUR_EMAIL>` with your details:

```sh
kubectl create secret docker-registry ghcr-secret \
    --docker-server=ghcr.io \
    --docker-username=<YOUR_GITHUB_USERNAME> \
    --docker-password=<YOUR_GITHUB_PAT> \
    --docker-email=<YOUR_EMAIL> \
    -n grow
```

### 2. Reference the Secret in Your Chart

In your `values.yaml`:
```yaml
imagePullSecrets:
  - name: ghcr-secret
```

This ensures Kubernetes uses your secret to authenticate with GHCR when pulling images.

For more details, see the [Kubernetes documentation on imagePullSecrets](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/).


# Check for pod deployment to Rancher Desktop
nerdctl --namespace k8s.io images         