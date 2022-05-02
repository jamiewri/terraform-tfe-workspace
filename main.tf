resource "tfe_workspace" "workspace" {
  organization = var.organization
  name         = var.name
  description  = var.description
  tag_names    = var.tag_names
  auto_apply   = var.auto_apply
  vcs_repo {
    identifier     = var.vcs_repo_identifier
    branch         = var.vcs_repo_branch
    oauth_token_id = var.vcs_repo_oauth_token_id
  }
}

