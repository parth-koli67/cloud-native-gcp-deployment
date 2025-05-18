project_id = "<project-id>"
region     = "us-central1"
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
    subnet_ip             = "10.105.230.0/28"
    subnet_region         = "us-central1"
    subnet_private_access = "true"
    subnet_flow_logs      = "false"
  },
  {
    subnet_name           = "gke-pvt-us-est1-subnet"
    subnet_ip             = "10.105.228.0/23"
    subnet_region         = "us-central1"
    subnet_private_access = "true"
    subnet_flow_logs      = "false"
  }
]
secondary_ranges = {
  gke-pvt-us-est1-subnet = [
    {
      range_name    = "gke-pod-range"
      ip_cidr_range = "10.105.192.0/19"
    },
    {
      range_name    = "gke-svc-range"
      ip_cidr_range = "10.105.224.0/22"
    }
  ]
}
