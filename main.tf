provider "tfe" {}

resource "tfe_workspace" "main" {
  name         = "test-student-1"
  organization = "prisma-cloud-compute"
  vcs_repo {
    identifier     = var.repo
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_variable" "gcp_credentials" {
  key          = "GOOGLE_CREDENTIALS"
  value        = var.GOOGLE_CREDENTIALS
  category     = "env"
  workspace_id = tfe_workspace.main.id
  sensitive    = true
}

resource "tfe_variable" "gcp_project" {
  key          = "GOOGLE_PROJECT"
  value        = var.GOOGLE_PROJECT
  category     = "env"
  workspace_id = tfe_workspace.main.id
}
