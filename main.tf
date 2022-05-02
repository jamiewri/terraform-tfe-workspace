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

data "tfe_team" "team" {
  for_each = {
    for team in var.teams_access :
    team.name => team
  }

  name         = each.value.name
  organization = var.organization
}

resource "tfe_team_access" "team_access" {
  for_each = {
    for team in var.teams_access :
    team.name => team
  }

  access = each.value.access
  team_id = data.tfe_team.team[each.value.name].id
  workspace_id = tfe_workspace.workspace.id
}
