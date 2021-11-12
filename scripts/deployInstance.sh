#!/usr/bin/env bash

NAMESPACE="$1"
DBPW="$2"

CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)

if [[ -z "${TMP_DIR}" ]]; then
  TMP_DIR="./.tmp"
fi
mkdir -p "${TMP_DIR}"


if [[ "$3" == "destroy" ]]; then
    echo "removing mongo release..."
    # remove the the release
    kubectl delete StatefulSet mas-mongo-ce -n ${NAMESPACE}
else
    echo "adding mongo release..."
    # deploy the release
    sed s/%DB_PASS%/${DBPW}/g ${CHARTS_DIR}/mas-mongo-ce.yaml > ${TMP_DIR}/prod-mas-mongo-ce.yaml
    kubectl apply -f "${TMP_DIR}/prod-mas-mongo-ce.yaml" -n ${NAMESPACE}
    sleep 6m
 
    SVCNAME=$(kubectl get svc -n mongo -o=jsonpath="{.items..metadata.name}")
    echo ${SVCNAME} > ${TMP_DIR}/mas-svc-name

fi
