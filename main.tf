provider "tfe" {}

resource "tfe_workspace" "main" {
  name         = "test-student-1"
  organization = "prisma-cloud-compute"
  # vcs_repo     = var.repo
}

