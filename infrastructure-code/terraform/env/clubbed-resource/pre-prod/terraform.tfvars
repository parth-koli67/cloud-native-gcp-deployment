###########################IAM SA#####################

# project_id = "searce-playground-v2"
project_id = "<project-id>"
region     = "us-central1"


#Global
terraform_owner_email = "tf-sa-17@<project-id>.iam.gserviceaccount.com"

service_account_terraform = {
  role_name       = "tf_role"
  permissions = [
    "artifactregistry.repositories.create",
      "artifactregistry.repositories.delete",
      "artifactregistry.repositories.get",
      "artifactregistry.repositories.getIamPolicy",
      "artifactregistry.repositories.list",
      "artifactregistry.repositories.setIamPolicy",
      "artifactregistry.repositories.update",
      "artifactregistry.repositories.uploadArtifacts",
      "cloudsql.instances.create",
      "cloudsql.instances.delete",
      "cloudsql.instances.get",
      "cloudsql.instances.list",
      "cloudsql.users.delete",
      "compute.firewalls.create",
      "compute.instances.attachDisk",
      "compute.instances.create",
      "compute.instances.createTagBinding",
      "compute.instances.delete",
      "compute.instances.detachDisk",
      "compute.instances.get",
      "container.clusters.create",
      "container.clusters.update",
      "container.clusters.get",
      "container.clusters.delete",
      "container.clusters.list",
      "container.clusters.getIamPolicy",
      "container.clusters.setIamPolicy",
      "container.operations.get",
      "container.operations.list",
      "compute.instances.list",
      "compute.instances.setDeletionProtection",
      "compute.addresses.useInternal",
      "compute.instances.setTags",
      "compute.instances.setIamPolicy",
      "compute.instances.setLabels",
      "compute.instances.setMetadata",
      "compute.instances.setServiceAccount",
      "compute.instances.start",
      "compute.instances.stop",
      "compute.instances.update",
      "compute.instances.use",
      "compute.addresses.deleteInternal",
      "compute.zones.list",
      "compute.zones.get",
      "compute.zoneOperations.get",
      "compute.addresses.createInternal",
      "compute.disks.create",
      "compute.disks.get",
      "compute.disks.delete",
      "compute.disks.createSnapshot",
      "compute.disks.update",
      "compute.disks.use",
      "compute.disks.setLabels",
      "compute.networks.get",
      "resourcemanager.projects.get",
      "storage.buckets.create",
      "storage.buckets.createTagBinding",
      "storage.buckets.delete",
      "storage.buckets.deleteTagBinding",
      "storage.buckets.get",
      "storage.buckets.getIamPolicy",
      "storage.buckets.list",
      "storage.buckets.update",
      "storage.buckets.get",
      "storage.objects.create",
      "storage.objects.get",
      "storage.objects.getIamPolicy",
      "storage.objects.list",
      "storage.objects.setIamPolicy",
      "storage.objects.update",
      "storage.objects.delete",
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
      "certificatemanager.certmapentries.create",
      "certificatemanager.certmapentries.delete",
      "certificatemanager.certmapentries.get",
      "certificatemanager.certmapentries.list",
      "certificatemanager.certmaps.create",
      "certificatemanager.certmaps.delete",
      "certificatemanager.certmaps.list",
      "certificatemanager.certmaps.use",
      "certificatemanager.certs.create",
      "certificatemanager.certs.delete",
      "certificatemanager.certs.get",
      "certificatemanager.certs.list",
      "certificatemanager.certs.use",
      "certificatemanager.dnsauthorizations.create",
      "certificatemanager.dnsauthorizations.delete",
      "certificatemanager.dnsauthorizations.get",
      "certificatemanager.dnsauthorizations.list",
      "certificatemanager.dnsauthorizations.use",
      "certificatemanager.operations.get",
      "serviceusage.services.list",
      "resourcemanager.projects.setIamPolicy",
      "compute.instanceGroupManagers.get",
      "serviceusage.services.enable",
      "compute.networks.create",
      "compute.networks.delete",
      "compute.subnetworks.create",
      "compute.subnetworks.delete",
      "compute.networks.updatePolicy",
      "compute.subnetworks.get",
      "compute.subnetworks.use",
      "compute.subnetworks.list",
      "compute.firewalls.create",
      "compute.firewalls.delete",
      "compute.firewalls.get",
      "compute.firewalls.list",
      "compute.firewalls.update",
      "compute.routers.create",
      "compute.routers.delete",
      "compute.routers.get",
      "compute.routers.list",
      "compute.routers.update",
      "redis.instances.getAuthString",
      "dns.changes.create",
      "dns.managedZones.create",
      "dns.managedZones.delete",
      "dns.managedZones.get",
      "dns.managedZones.list",
      "dns.resourceRecordSets.create",
      "dns.resourceRecordSets.delete",
      "dns.resourceRecordSets.get",
      "dns.resourceRecordSets.list",
      "dns.resourceRecordSets.update",
      "dns.changes.get",
      "compute.addresses.create",
      "compute.addresses.setLabels",
      "compute.addresses.get",
      "compute.addresses.list",
      "compute.addresses.delete",
      "compute.globalAddresses.createInternal",
      "compute.networks.use",
      "compute.globalAddresses.setLabels",
      "compute.globalAddresses.delete",
      "compute.globalAddresses.list",
      "compute.globalAddresses.use",
      "compute.globalAddresses.get",
      "iam.roles.create",
      "iam.roles.delete",
      "iam.roles.get",
      "iam.roles.list",
      "iam.roles.undelete",
      "resourcemanager.projects.getIamPolicy",
      "iam.roles.update",
      "servicenetworking.services.addPeering",
      "servicenetworking.services.get",
      "servicenetworking.services.deleteConnection",
      "iam.serviceAccounts.create",
      "iam.serviceAccounts.createTagBinding",
      "iam.serviceAccounts.delete",
      "file.locations.get",
      "file.instances.create",
      "file.instances.update",
      "file.instances.delete",
      "file.instances.get",
      "file.instances.list",
      "file.operations.get",
      "file.operations.list",
      "file.operations.cancel",
      "file.operations.delete",
      "file.backups.create",
      "file.backups.update",
      "file.backups.delete",
      "file.backups.get",
      "file.backups.list",
      "file.snapshots.create",
      "file.snapshots.update",
      "file.snapshots.delete",
      "file.snapshots.get",
      "file.snapshots.list",
  ]
}

/*****************************************
  Terraform Custom Role Details
*****************************************/

project_services_api = {
  upland_network = {
    project_id                 = "<project-id>"
    activate_apis              = ["serviceusage.googleapis.com", "cloudresourcemanager.googleapis.com", "iam.googleapis.com", "storage.googleapis.com", "container.googleapis.com", "logging.googleapis.com", "vpcaccess.googleapis.com", "servicenetworking.googleapis.com", "cloudbilling.googleapis.com", "secretmanager.googleapis.com", "connectors.googleapis.com", "artifactregistry.googleapis.com", "compute.googleapis.com", "monitoring.googleapis.com", "sqladmin.googleapis.com", "servicenetworking.googleapis.com", "networkmanagement.googleapis.com", "certificatemanager.googleapis.com", "file.googleapis.com"]
    disable_dependent_services = true
    disable_services_on_destroy = true
  }
}


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
  role_name       = "mgmt-role"
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


###########################vpc subnet#####################

vpc_config = {
  "vpc1" = {
    project_id              = "<project-id>"
    network_name            = "main-vpc"
    shared_vpc_host         = false
    auto_create_subnetworks = false
  }
}

subnets = [
  {
    subnet_name           = "mgmt-pvt-us-est1-subnet"
    subnet_ip             = "10.250.118.16/28"
    subnet_region         = "us-central1"
    subnet_private_access = "true"
    subnet_flow_logs      = "false"
  },
  {
    subnet_name           = "gke-pvt-us-est1-subnet"
    subnet_ip             = "10.250.112.0/23"
    subnet_region         = "us-central1"
    subnet_private_access = "true"
    subnet_flow_logs      = "false"
  }
]
secondary_ranges = {
  gke-pvt-us-est1-subnet = [
    {
      range_name    = "gke-pod-range"
      ip_cidr_range = "10.250.116.0/23"
    },
    {
      range_name    = "gke-svc-range"
      ip_cidr_range = "10.250.114.0/23"
    }
  ]
}


###########################Firewall#####################

vpc_name   = "main-vpc"

firewall_rules = [
  {
    network       = "main-vpc"
    name          = "main-vpc-allow-iap-access-fw"
    protocol      = "tcp"
    ports         = ["22"]
    source_ranges = ["35.235.240.0/20"]
    source_tags   = []
    target_tags   = ["allow-iap-access"]
  },
  {
    network       = "main-vpc"
    name          = "main-vpc-allow-google-hc-fw"
    protocol      = "tcp"
    ports         = ["80", "443"]
    source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
    source_tags   = []
    target_tags   = ["allow-hc-access"]
  },
  # {
  #   network       = "main-vpc"
  #   name          = "main-vpc-allow-gke"
  #   protocol      = "tcp"
  #   ports         = ["6443"]
  #   source_ranges = ["10.10.131.2/32"]
  #   source_tags   = []
  #   target_tags   = ["allow-gke-access"]
  # },
]


###########################NAT Router#####################

nat_name     = "main-vpc-us-est1-nat"
router_name  = "main-vpc-us-est1-cr"
address_name = "main-vpc-us-est1-nat-ext-ip"

/*****************************
  Details of Compute Engines 
 *****************************/

compute_instance = {
  compute_instance_01 = {
    machine_name            = "mgmt-vm"
    project_id              = "<project-id>"
    machine_type            = "e2-medium"
    region                  = "us-central1"
    enable_external_ip      = false
    generate_internal_ip    = false
    internal_ip_address     = ["10.250.118.20"]
    network                 = "main-vpc"
    subnetwork              = "projects/<project-id>/regions/us-central1/subnetworks/mgmt-pvt-us-est1-subnet"
    network_tags            = ["allow-iap-access"]
    instance_count          = 1
    vm_description          = "Management VM"
    machine_zone            = ["us-central1-b"]
    vm_deletion_protect     = true
    instance_image_selflink = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20220712" # "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20241004"
    service_account = {
      email  = "gce-sa@<project-id>.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    instance_labels = {
      "purpose" = "mgmt-vm",
      "env"     = "pre-prod"
    }
    boot_disk0_info = {
      disk_size_gb = 30
      disk_type    = "pd-standard"
    }
  }
}
