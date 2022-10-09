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
az group create -l westus -n TfBootstrapGroup
az storage account create -n tfboostrapsa -g TfBootstrapGroup -l westus --sku Standard_LRS

```
Clean up:
```bash
az group delete -n TfBootstrapGroup
```

# TODO: with Terraform
* Create Service Principle for Pipeline
* Create Storage Account for Terraform Pipeline
* Create Pipeline