/**
 * Copyright 2017 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
module "loadbalancer" {
  source                = "../../../../modules/networking/loadbalancer/external_https_lb"
  name                  = var.name
  global_static_ip_name = var.global_static_ip
  neg_name              = var.neg_name
  https_redirect_name   = var.https_redirect_name
  project               = var.project_id
  firewall_networks     = []
  ssl                   = true
  use_ssl_certificates  = true
  certificate_map      = var.certificate_map
  create_address        = true
  address               = "projects/${var.project_id}/global/addresses/${var.global_static_ip}"
  create_url_map        = false
  url_map               = google_compute_url_map.urlmap.self_link
  http_forward          = false
  https_redirect        = true

  backends = var.backend_services
}

/* URL Mapping */

resource "google_compute_url_map" "urlmap" {
  project         = var.project_id
  name            = "${var.name}-ext-us-central1"
  description     = "${var.name} URL Map"
  default_service = module.loadbalancer.backend_services["python-app-neg"].self_link


/******************************************
  Host - Path rules for Connectivity-Hub
*****************************************/

  host_rule {
    hosts        = ["customer1.ch.baquality.net"] # host for connectivity-hub
    path_matcher = "connectivity-hub-rule"
  }
  path_matcher {
    name            = "connectivity-hub-rule"
    default_service = module.loadbalancer.backend_services["python-app-neg"].self_link # module.bucket-backends[0].id   
    path_rule {
      paths = [
        "/"
      ]
      url_redirect {
          path_redirect = "/ConnectivityHub"
          redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
          strip_query = false
        }
    }
  }

/******************************************
  Host - Path rules for Auto-Classifier
*****************************************/
  host_rule {
    hosts        = ["customer1.ac.baquality.net"]  # host for auto-classifier
    path_matcher = "auto-classifier-rule"
  }
  path_matcher {
    name            = "auto-classifier-rule"
    default_service = module.loadbalancer.backend_services["ac-pre-prod-neg"].self_link
      path_rule {
      paths = [
        "/*"
      ]
      service = module.loadbalancer.backend_services["ac-pre-prod-neg"].self_link
      } 
    }

/******************************************
  Host - Path rules for Sharepointaddin
*****************************************/
  host_rule {
    hosts        = ["sharepointaddin.baquality.net"]  # host for sharepoint-connectors
    path_matcher = "ac-addin-rule"
  }
  path_matcher {
    name            = "ac-addin-rule"
    default_service = module.loadbalancer.backend_services["addin-neg"].self_link
      path_rule {
      paths = [
        "/"
      ]
        url_redirect {
          path_redirect = "/pages/default.aspx"
          redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
          strip_query = false
        }
      }
  }

/******************************************
  Host - Path rules for Smarthub-Admin
*****************************************/
  host_rule {
    hosts        = ["customer1.sh-admin.baquality.net"]  # host for snarthub-admin
    path_matcher = "smarthub-admin-rule"
  }
  path_matcher {
    name            = "smarthub-admin-rule"
    default_service = module.loadbalancer.backend_services["sh-admin-neg"].self_link
      path_rule {
      paths = [
        "/"
      ]
        url_redirect {
          path_redirect = "/_admin"
          redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
          strip_query = false
        }
      }
  }

/******************************************
  Host - Path rules for Smarthub-UI
*****************************************/
  host_rule {
    hosts        = ["customer1.sh.baquality.net"]  # host for snarthub-ui
    path_matcher = "smart-hub-ui"
  }
  path_matcher {
    name            = "smart-hub-ui"
    default_service = module.loadbalancer.backend_services["sh-ui-neg"].self_link
      path_rule {
      paths = [
        "/"
      ]
      service = module.loadbalancer.backend_services["sh-ui-neg"].self_link
    }
  }

/******************************************
  Host - Path rules for ArgoCD
*****************************************/
    host_rule {
    hosts        = ["gcp-argocd.baquality.net"]  # host for snarthub-ui
    path_matcher = "argocd-rule"
  }
  path_matcher {
    name            = "argocd-rule"
    default_service = module.loadbalancer.backend_services["argocd-pre-prod-neg"].self_link
      path_rule {
      paths = [
        "/argocd"
      ]
      service = module.loadbalancer.backend_services["argocd-pre-prod-neg"].self_link
    }
  }

/******************************************
  Host - Path rules for Lucene
*****************************************/
  host_rule {
    hosts        = ["autoclassifierlucene.baquality.net"]  # host for lucene
    path_matcher = "lucene-rule"
  }
  path_matcher {
    name            = "lucene-rule"
    default_service = module.loadbalancer.backend_services["lucene-pre-prod-neg"].self_link
      path_rule {
      paths = [
        "/*"
      ]
      service = module.loadbalancer.backend_services["lucene-pre-prod-neg"].self_link
      } 
    }
}
