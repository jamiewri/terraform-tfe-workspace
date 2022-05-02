variable "name" {
  type    = string
  default = ""
}

variable "organization" {
  type    = string
  default = ""
}

variable "tag_names" {
  type    = list(any)
  default = []
}

variable "auto_apply" {
  type    = string
  default = "false"
}

variable "vcs_repo_identifier" {
  type    = string
  default = ""
}

variable "vcs_repo_branch" {
  type    = string
  default = "master"
}

variable "vcs_repo_oauth_token_id" {
  type    = string
  default = ""
}

