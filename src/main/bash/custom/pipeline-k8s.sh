#!/bin/bash

function logInToPaas() {
    local clusterName="PAAS_${ENVIRONMENT}_CLUSTER_NAME"
	local k8sClusterName="${!clusterName}"

    local clusterRegion="PAAS_${ENVIRONMENT}_CLUSTER_REGION"
    local k8sClusterRegion="${!clusterRegion}"

    aws eks --region ${k8sClusterRegion:-us-east-1} update-kubeconfig --name ${k8sClusterName}
}

export -f logInToPaas