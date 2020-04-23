provider "tfe" {}

resource "tfe_workspace" "main" {
  count        = var.lab_instances
  name         = "test-student-${count.index + 1}"
  organization = "prisma-cloud-compute"
  auto_apply   = true
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
  value        = count.index + 1
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}

resource "tfe_variable" "instance_id" {
  count        = length(tfe_workspace.main[*].id)
  key          = "initial_node_count"
  value        = var.initial_node_count
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}
