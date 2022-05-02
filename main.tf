resource "tfe_workspace" "workspace" {
  organization = var.organization
  name         = var.name
  description  = var.description
  tag_names    = var.tags
  auto_apply   = var.auto_apply
  vcs_repo {
    identifier     = vcs_repo_identifier
    branch         = vcs_repo_branch
    oauth_token_id = vcs_repo_oauth_token_id
  }
}

