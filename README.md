# A Terraform module to manage Terraform Cloud workspaces

## Example usage
This module uses a custom data structure called workspaces to manage terraform cloud workspaces and the team access model.

Example `variables.tf`
```hcl
variable "organization" {
  type    = string
  default = ""
}

variable "oauth_token_id" {
  type    = string
  default = ""
}

variable "workspaces" {
  type = list(object({
    name        = string
    description = string
    tags        = list(string)
    auto_apply  = string
    vcs_repo = object({
      identifier = string
      branch     = string
    })
    teams_access = list(object({
      name   = string
      access = string
    }))
  }))

  default = []
}

variable "teams" {
  type = list(object({
    name = string
  }))

  default = []
}
```

Example `terraform.tfvars`
```hcl
organization   = "your-org-name-here"
oauth_token_id = "ot-xxxxxxxxxxxxxxx"

teams = [
  {
    name = "developers"
  },
  {
    name = "admins"
  },
  {
    name = "managers"
  }
]

workspaces = [
  {
    name        = "tfc-aws-network-prod",
    description = "A workspace to managing shared networking objects in prod environment."
    tags        = ["demo", "aws", "network", "prod"]
    auto_apply  = "true"
    vcs_repo = {
      identifier = "jamiewri/tfc-aws-network"
      branch     = "master"
    }
    teams_access = [
      {
        name   = "admins"
        access = "admin"
      },
      {
        name   = "developers"
        access = "write"
      },
      {
        name   = "managers"
        access = "read"
      }
    ]
  }
]
```

Invoking the module
```hcl
module "workspace" {
  source  = "github.com/jamiewri/terraform-tfe-workspace"
  version = "~> 0.1.7"

  for_each = {
    for index, workspace in var.workspaces :
    workspace.name => workspace
  }

  name         = each.value.name
  organization = var.organization
  description  = each.value.description
  tag_names    = each.value.tags
  auto_apply   = each.value.auto_apply

  vcs_repo_identifier     = each.value.vcs_repo.identifier
  vcs_repo_branch         = each.value.vcs_repo.branch
  vcs_repo_oauth_token_id = var.oauth_token_id

  teams_access = each.value.teams_access
}
```
