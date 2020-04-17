provider "tfe" {}

resource "tfe_workspace" "main" {
  name         = "test-student-2"
  organization = "prisma-cloud-compute"
  # vcs_repo     = var.repo
}

