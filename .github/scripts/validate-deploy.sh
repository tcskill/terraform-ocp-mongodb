#!/usr/bin/env bash

KUBECONFIG=$(cat ./kubeconfig)
NAMESPACE=$(cat ./mongo_namespace)

#wait for the deployments to finish
sleep 5m

kubectl rollout status statefulset/mas-mongo-ce -n ${NAMESPACE}
if [[ $? -ne 0 ]]; then
    echo "mongo deployment failed with exit code $? in namespace ${NAMESPACE}"
    exit 1
fi
