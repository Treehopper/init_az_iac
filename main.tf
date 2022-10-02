terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
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

resource"azuredevops_project""project" {
  name               = "Terraform DevOps Project"
  description        = "Bootstrap AzDevOps <-> Terraform integragtion"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  features = {
      "testplans" = "disabled"
      "artifacts" = "disabled"
      "boards" = "disabled"
  }
}

resource"azuredevops_git_repository""repo" {
  project_id = azuredevops_project.project.id
  name       = "Sample Empty Git Repository"
  default_branch = "refs/heads/master"

  initialization {
    init_type = "Clean"
  }
}

resource"azuredevops_build_definition""build" {
  project_id =  azuredevops_project.project.id
  name       = "DevOps Build Pipeline"

  ci_trigger {
    use_yaml =true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     =  azuredevops_git_repository.repo.id
    branch_name =  azuredevops_git_repository.repo.default_branch
    yml_path    = "azure-pipeline.yaml"
  }

  variable {
    name      = "mypipelinevar"
    value     = "Hello From Az DevOps Pipeline!"
    is_secret = false
  }
}