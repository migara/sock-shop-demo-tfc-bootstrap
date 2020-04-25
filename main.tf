provider "tfe" {}

data "tfe_workspace" "bootstrap" {
  name         = "sock-shop-demo-tfc-bootstrap"
  organization = "prisma-cloud-compute"
}

# resource "tfe_run_trigger" "test" {
#   count                 = var.lab_instances
#   workspace_external_id = tfe_workspace.main[count.index].external_id
#   sourceable_id         = data.tfe_workspace.bootstrap.external_id
# }

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

resource "tfe_variable" "cluster_name" {
  count        = length(tfe_workspace.main[*].id)
  key          = "cluster_name"
  value        = "${var.prefix}-${count.index + 1}"
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}

resource "tfe_variable" "initial_node_count" {
  count        = length(tfe_workspace.main[*].id)
  key          = "initial_node_count"
  value        = var.initial_node_count
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}

resource "tfe_variable" "region" {
  count        = length(tfe_workspace.main[*].id)
  key          = "region"
  value        = var.region
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}

resource "tfe_variable" "location" {
  count        = length(tfe_workspace.main[*].id)
  key          = "location"
  value        = var.location
  category     = "terraform"
  workspace_id = tfe_workspace.main[count.index].id
}
