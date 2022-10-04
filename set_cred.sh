#!/bin/sh
 
# See: https://docs.microsoft.com/en-us/azure/devops/cli/log-in-via-pat?view=azure-devops&tabs=unix
# and: https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page

export TF_VAR_orgurl="https://dev.azure.com/${org}"
export TF_VAR_pat=""