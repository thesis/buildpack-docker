FROM    circleci/buildpack-deps:bionic-curl
ARG     CLOUD_SDK_VERSION=220.0.0
ENV     CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

RUN     export CLOUD_SDK_REPO="cloud-sdk-bionic" && \
        echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list && \
        cat /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
        sudo apt-get update && \
        sudo apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-app-engine-python=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-app-engine-python-extras=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-app-engine-java=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-app-engine-go=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-datalab=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-datastore-emulator=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-pubsub-emulator=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-bigtable-emulator=${CLOUD_SDK_VERSION}-0 \
            google-cloud-sdk-cbt=${CLOUD_SDK_VERSION}-0 \
            kubectl && \
        gcloud config set core/disable_usage_reporting true && \
        gcloud config set component_manager/disable_update_check true && \
        gcloud config set metrics/environment github_docker_image && \
        gcloud --version && \
        docker --version && kubectl version --client && \
        sudo rm -rf /var/lib/apt/lists/* && \
        sudo curl -Lo /usr/local/bin/skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && sudo chmod +x /usr/local/bin/skaffold
