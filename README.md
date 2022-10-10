# Summary
Initialize Azure DevOps for Bootstrapping a K8s Environment

# Set Azure Credentials
```bash
org="foobar"
source set_cred.sh
```

# Boostrap Azure Backend for Terraform
```bash
docker run -it --rm mcr.microsoft.com/azure-cli
az login

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate

az group create --name $RESOURCE_GROUP_NAME --location eastus
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

cd terraform
terraform init
terraform apply -target=gitops_pipeline -target=service_principal
```

Clean up:
```bash
az group delete -n $RESOURCE_GROUP_NAME
```

# TODO: with Terraform
* Create Service Principle for Pipeline
* Create Storage Account for Terraform Pipeline
* Create Pipeline