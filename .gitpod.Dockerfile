FROM gitpod/workspace-full

COPY --from=ghcr.io/treehopper/the-kraken:latest /usr/local/bin/terraform /usr/local/bin/

#RUN DEBIAN_FRONTEND=noninteractive \
#    apt-get -qq update \
#    && apt-get -qq install -y python3; \
#    apt-get -qq clean;

# Azure CLI
#RUN curl -fsSL https://aka.ms/InstallAzureCLIDeb | bash - \
#    && az extension add --system --yes --name azure-devops