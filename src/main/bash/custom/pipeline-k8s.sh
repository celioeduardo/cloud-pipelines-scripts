#!/bin/bash

function logInToPaas() {
    local clusterName="PAAS_${ENVIRONMENT}_CLUSTER_NAME"
	local k8sClusterName="${!clusterName}"

    local clusterRegion="PAAS_${ENVIRONMENT}_CLUSTER_REGION"
    local k8sClusterRegion="${!clusterRegion}"

    echo "Path to kubectl [${KUBECTL_BIN}]"
	if [[ "${TEST_MODE}" == "false" && "${KUBECTL_BIN}" != "/"* ]]; then
		echo "Downloading CLI"
		curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/${SYSTEM}/amd64/kubectl" --fail
		KUBECTL_BIN="$(pwd)/${KUBECTL_BIN}"
	fi
	chmod +x "${KUBECTL_BIN}"
	echo "Removing current Kubernetes configuration from [${KUBE_CONFIG_PATH}]"
	rm -rf "${KUBE_CONFIG_PATH}" || echo "Failed to remove Kube config. Continuing with the script"

    echo "logInToPass aws region: ${k8sClusterRegion:-us-east-1} name ${k8sClusterName}"
    aws eks --region ${k8sClusterRegion:-us-east-1} update-kubeconfig --name ${k8sClusterName}
}

export -f logInToPaas