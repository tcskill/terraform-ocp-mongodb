#!/usr/bin/env bash

if [[ -z "${TMP_DIR}" ]]; then
    TMP_DIR=".tmp"
fi
mkdir -p "${TMP_DIR}"

NAMESPACE="$1"
CERTPATH="$2"

if [[ "$3" == "destroy" ]]; then
    kubectl delete configmap mas-mongo-ce-cert-map -n ${NAMESPACE}
else 
    echo "adding cert configmap..."
    kubectl create configmap mas-mongo-ce-cert-map --from-file=ca.crt=${CERTPATH}/ca.pem -n ${NAMESPACE}
fi
