provider "tfe" {}

resource "tfe_workspace" "main" {
  count        = var.lab_instances
  name         = "test-student-${count.index}"
  organization = "prisma-cloud-compute"
  vcs_repo {
    identifier     = var.repo
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_variable" "gcp_credentials" {
  count        = length(tfe_workspace.main[*].id)
  key          = "GOOGLE_CREDENTIALS"
  value        = var.GOOGLE_CREDENTIALS
  category     = "env"
  workspace_id = tfe_workspace.main[count.index].id
  sensitive    = true
}

resource "tfe_variable" "gcp_project" {
  count        = length(tfe_workspace.main[*].id)
  key          = "GOOGLE_PROJECT"
  value        = var.GOOGLE_PROJECT
  category     = "env"
  workspace_id = tfe_workspace.main[count.index].id
}

resource "tfe_variable" "instance_id" {
  count        = length(tfe_workspace.main[*].id)
  key          = "instance_id"
  value        = "2"
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}
