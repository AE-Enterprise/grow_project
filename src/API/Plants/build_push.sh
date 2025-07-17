#!/bin/bash
# Build and push Docker image to GitHub Container Registry (GHCR)
# Usage: ./build_push.sh <service-name> <tag>

set -e

SERVICE_NAME=${1:-plants}
TAG=${2:-latest}
GHCR_REPO="ghcr.io/ae-enterprise/grow_project/$SERVICE_NAME"

# Build the image

docker build -t "$GHCR_REPO:$TAG" .

echo "Pushing image to $GHCR_REPO:$TAG"
docker push "$GHCR_REPO:$TAG"

echo "Done."
