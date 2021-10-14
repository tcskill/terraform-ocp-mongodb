#!/usr/bin/env bash

NAMESPACE="$1"
CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)

#if [[ "$2" == "destroy" ]]; then
    #echo "removing mongo release..."
    # remove the the release
    #kubectl delete ReplicaSet mas-mongo-ce -n ${NAMESPACE}
#else
    echo "adding mongo release..."
    # deploy the release
    kubectl apply -f "${CHARTS_DIR}/mas-mongo-ce.yaml" -n ${NAMESPACE}
#fi
