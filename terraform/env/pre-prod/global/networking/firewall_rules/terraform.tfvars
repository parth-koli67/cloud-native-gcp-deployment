project_id = "personal-project-1-458808"
region     = "us-central1"
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
    ports         = ["0-65535"]
    source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
    source_tags   = []
    target_tags   = ["allow-hc-access"]
  },
]
