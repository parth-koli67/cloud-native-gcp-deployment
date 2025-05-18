/******************************************
  Details of Artifact Repository
 *****************************************/

project_id = "<project-id>"

repo = {
  repo_01 = {
    repo_name   = "application-repo"
    region      = "us-central1"
    format      = "DOCKER"
    description = "For Docker Images"
    labels = {
      environment = "pre-prod",
      purpose     = "docker-images",
      region      = "us-central1"
    }
  }
}
