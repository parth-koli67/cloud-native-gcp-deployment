project_id = "<project-id>"
region     = "us-central1"

service_account_gke = {
  service_account = "gke-sa"
  role_name       = "gke_role"
  permissions = [
    "artifactregistry.repositories.get",
    "artifactregistry.repositories.list",
    "cloudsql.backupRuns.get",
    "cloudsql.backupRuns.list",
    "cloudsql.databases.get",
    "cloudsql.databases.list",
    "cloudsql.instances.connect",
    "cloudsql.instances.export",
    "cloudsql.instances.get",
    "cloudsql.instances.list",
    "cloudsql.users.list",
    "storage.objects.get",
    "storage.objects.list",
    "compute.networks.get",
    "compute.subnetworks.get",
    "compute.subnetworks.use",
    "compute.addresses.get",
    "compute.addresses.list",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
  ]
}

service_account_mgmt_gce = {
  service_account = "gce-sa"
  role_name       = "managementrole"
  permissions = [
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "logging.logEntries.create",
    "monitoring.metricDescriptors.create",
    "monitoring.metricDescriptors.get",
    "monitoring.metricDescriptors.list",
    "monitoring.monitoredResourceDescriptors.get",
    "monitoring.monitoredResourceDescriptors.list",
    "monitoring.timeSeries.create",
    "resourcemanager.projects.get",
    "storage.buckets.get",
    "storage.objects.create",
    "storage.objects.get",
    "storage.objects.getIamPolicy",
    "storage.objects.list",
    "storage.objects.setIamPolicy",
    "storage.objects.update",
    "compute.instances.setServiceAccount",
    "compute.instances.start",
    "compute.instances.stop",
    "compute.networks.get",
    "certificatemanager.dnsauthorizations.create",
    "certificatemanager.operations.get",
    "certificatemanager.dnsauthorizations.list",
    "certificatemanager.dnsauthorizations.get",
    "certificatemanager.certs.create",
    "certificatemanager.certs.list",
    "certificatemanager.certs.get",
    "certificatemanager.certs.delete",
    "certificatemanager.certs.use",
    "certificatemanager.dnsauthorizations.use",
    "certificatemanager.dnsauthorizations.delete",
    "certificatemanager.certmaps.create",
    "certificatemanager.certmaps.list",
    "certificatemanager.certmaps.use",
    "certificatemanager.certmaps.delete",
    "certificatemanager.certmapentries.create",
    "certificatemanager.certmapentries.list",
    "certificatemanager.certmapentries.delete",
    "certificatemanager.certmapentries.get",
  ]
}

service_account_github_acitons_sa = {
  service_account = "github-actions-sa"

}