#Artifact Repository Module
module "artifact_registry" {
  source      = "../../../../modules/artifact-registry"
  for_each    = var.repo
  region_name = each.value.region
  project_id  = var.project_id
  repo_id     = each.value.repo_name
  format_type = each.value.format
  labels      = each.value.labels
  description = each.value.description
}
