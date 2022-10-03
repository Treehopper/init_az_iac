FROM gitpod/workspace-full

COPY --from=hashicorp/terraform:light /bin/terraform /bin/

RUN sudo DEBIAN_FRONTEND=noninteractive \
    apt-get -qq update \
    && sudo apt-get -qq install -y python3; \
    sudo apt-get -qq clean;

# Azure CLI
RUN curl -fsSL https://aka.ms/InstallAzureCLIDeb | sudo bash - \
    && sudo az extension add --system --yes --name azure-devops