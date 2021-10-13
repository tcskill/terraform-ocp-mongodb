#!/usr/bin/env bash

if [[ -z "${TMP_DIR}" ]]; then
    TMP_DIR=".tmp"
fi
mkdir -p "${TMP_DIR}"

NAMESPACE="$1"
CERTPATH="$2"



if [[ "$3" == "destroy" ]]; then
    kubectl delete configmap mas-mongo-ce-cert-map -n ${NAMESPACE}
    kubectl delete secret mas-mongo-ce-cert-secret -n ${NAMESPACE}
else 
    echo "adding mongon configmap..."
    kubectl create configmap mas-mongo-ce-cert-map --from-file=ca.crt=${CERTPATH}/ca.pem -n ${NAMESPACE}
    echo "adding mongo secret..."
    kubectl create secret tls mas-mongo-ce-cert-secret --cert=${CERTPATH}/server.crt --key=${CERTPATH}/server.key -n ${NAMESPACE}
fi
