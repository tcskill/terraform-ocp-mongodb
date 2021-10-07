#!/usr/bin/env bash

NAMESPACE="$1"
CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)

if [[ "$2" == "destroy" ]]; then
    echo "removing chart extension..."
    # chart extension
    kubectl delete CustomResourceDefinition mongodbcommunity.mongodbcommunity.mongodb.com
else 
    # deploy the chart extension needed
    kubectl create -f "${CHARTS_DIR}/mongodbcommunity.yaml" -n ${NAMESPACE}
fi





