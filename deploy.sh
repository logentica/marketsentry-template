#!/bin/bash
set -euo pipefail

# Simple Template - One-Click Deployment Script
# Usage: ./deploy.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
echo_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
echo_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check for required tools
for cmd in git yq kubectl; do
    if ! command -v $cmd &> /dev/null; then
        echo_error "$cmd is required but not installed"
        exit 1
    fi
done

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo_error "You have uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Extract configuration
SITE_NAME=$(yq '.site.name' values.yaml)
NAMESPACE=$(yq '.namespace' values.yaml)
HOSTNAME=$(yq '.ingress.hosts[0].host' values.yaml)

echo "================================================"
echo "Simple Template - Deploy"
echo "================================================"
echo "Site:      $SITE_NAME"
echo "Namespace: $NAMESPACE"
echo "URL:       https://$HOSTNAME"
echo "================================================"
echo ""

# Push to trigger CI/CD
echo_info "Pushing to GitHub to trigger CI/CD..."
git push

# Wait for GitHub Actions
echo_info "Waiting for GitHub Actions to build (this may take 1-2 minutes)..."
sleep 60

# Trigger ArgoCD sync
echo_info "Triggering ArgoCD sync..."
kubectl annotate application "$SITE_NAME" argocd.argoproj.io/refresh=hard -n argocd --overwrite 2>/dev/null || {
    echo_warn "Could not trigger ArgoCD sync automatically"
    echo_warn "The application may not exist yet, or ArgoCD will sync on its own"
}

# Wait for pods
echo_info "Waiting for pods to be ready..."
for i in {1..30}; do
    READY=$(kubectl get pods -n "$NAMESPACE" -l "app.kubernetes.io/name=$SITE_NAME" -o jsonpath='{.items[*].status.conditions[?(@.type=="Ready")].status}' 2>/dev/null || echo "")
    if [ "$READY" = "True" ]; then
        echo_info "Pods are ready!"
        break
    fi
    echo "  Waiting... ($i/30)"
    sleep 5
done

echo ""
echo "================================================"
echo_info "Deployment complete!"
echo ""
echo "Your site should be available at:"
echo "  https://$HOSTNAME"
echo ""
echo "To check status:"
echo "  kubectl get pods -n $NAMESPACE"
echo "  kubectl get ingress -n $NAMESPACE"
echo "================================================"
