/*****************************
  Details of Compute Engines 
 *****************************/

compute_instance = {
  compute_instance_01 = {
    machine_name            = "mgmt-vm-us-est1-a-gce"
    project_id              = "personal-project-1-458808"
    machine_type            = "e2-medium"
    region                  = "us-central1"
    enable_external_ip      = false
    generate_internal_ip    = false
    internal_ip_address     = ["10.105.230.5"]
    network                 = "main-vpc"
    subnetwork              = "projects/personal-project-1-458808/regions/us-central1/subnetworks/mgmt-pvt-us-est1-subnet"
    network_tags            = ["allow-iap-access"]
    instance_count          = 1
    vm_description          = "Management VM"
    machine_zone            = ["us-central1-b"]
    vm_deletion_protect     = false
    instance_image_selflink = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20220712" # "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20241004"
    service_account = {
      email  = "gce-sa@personal-project-1-458808.iam.gserviceaccount.com"
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
