terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }

    azurerm = {
      source = "hashicorp/azurerm"
      version ="~> 2.6.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.5.1"
    }
  }
}

variable "pat" {
  type = string
}

variable "orgurl" {
  type = string
}

provider "azuredevops" {
  org_service_url       = var.orgurl
  personal_access_token = var.pat
}
provider "azuread" {
}

data"azurerm_client_config""current" {
}

provider"azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

## Service Principal for DevOps

resource"azuread_application""azdevopssp" {
  display_name ="azdevopsterraform"
}

resource"azuread_service_principal""azdevopssp" {
  application_id = azuread_application.azdevopssp.application_id
}

resource"azuread_service_principal_password""azdevopssp" {
  service_principal_id =  azuread_service_principal.azdevopssp.id
}

resource"azurerm_role_assignment""owner" {
  principal_id         =  azuread_service_principal.azdevopssp.id
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Owner"
}
