project_id = "<project-id>"
region     = "us-central1"
psa_config = {
  "psa-01" = {
    project_id    = "<project-id>"
    psa_name      = "main-vpc-psa"
    vpc_network   = "main-vpc"
    region        = "us-central1"
    vpc_address   = "10.105.232.0" #please provide the internal IP which is NOT in range with the subnet CIDR
    prefix_length = "22"
  }
}
