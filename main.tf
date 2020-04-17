provider "tfe" {}

resource "tfe_workspace" "main" {
  name         = "test-student-1"
  organization = "prisma-cloud-compute"
  vcs_repo {
    identifier = var.repo
    oauth_token_id = var.oauth_token_id
}

