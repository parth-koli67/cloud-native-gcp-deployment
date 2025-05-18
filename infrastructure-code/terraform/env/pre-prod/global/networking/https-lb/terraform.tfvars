/* GLOBAL */
project_id = "<project-id>"
region     = "us-central1"

/* VPC */
network_name        = "main-vpc"
name                = "upland-pre-prod-lb"
global_static_ip    = "main-vpc-lb-ext-ip-01"
neg_name            = "upland-pre-prod-lb-neg"
https_redirect_name = "upland-pre-prod-https-redirect-01"

certificate_map = "projects/<project-id>/locations/global/certificateMaps/upland-pre-prod-map"

backend_services = {

/******************************************
        CONNECTIVITY-HUB NEG
/******************************************/
  python-app-neg = {
    description                     = null
    protocol                        = "HTTP"
    port                            = 80
    port_name                       = "http"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = false
    compression_mode                = "DISABLED"
    security_policy                 = "upland-pre-prod-armor-rules"
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 55001
      host                = null
      logging             = false
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

    groups = [
      {
        group                        = "https://www.googleapis.com/compute/v1/projects/<project-id>/zones/us-central1-b/networkEndpointGroups/python-app-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      }
    ]
    iap_config = {
      enabled               = true
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }
  },


/******************************************
        AUTO-CLASSIFIER NEG
/******************************************/
  ac-pre-prod-neg = {
    description                     = null
    protocol                        = "HTTPS"
    port                            = 1967
    port_name                       = "https"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = false
    compression_mode                = "DISABLED"
    security_policy                 = "upland-pre-prod-armor-rules"
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 1967
      host                = null
      logging             = true
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

    groups = [
      {
        group                        = "https://www.googleapis.com/compute/v1/projects/<project-id>/zones/us-central1-b/networkEndpointGroups/ac-pre-prod-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      },
    ]
      iap_config = {
      enabled               = true
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }
  },

  /******************************************
        LUCENE NEG
/******************************************/
lucene-pre-prod-neg = {
    description                     = null
    protocol                        = "HTTPS"
    port                            = 1968
    port_name                       = "https"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = false
    compression_mode                = "DISABLED"
    security_policy                 = "upland-pre-prod-armor-rules"
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 1968
      host                = null
      logging             = true
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

    groups = [
      {
        group                        = "https://www.googleapis.com/compute/v1/projects/<project-id>/zones/us-central1-b/networkEndpointGroups/lucene-pre-prod-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      },
    ]
      iap_config = {
      enabled               = true
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }
  },

# /******************************************
#         SHAREPOINT-ADDIN
# /******************************************/
  addin-neg = {
    description                     = null
    protocol                        = "HTTPS"
    port                            = 443
    port_name                       = "https"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = false
    compression_mode                = "DISABLED"
    security_policy                 = "upland-pre-prod-armor-rules"
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 443
      host                = null
      logging             = false
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

      groups = [
      {
        group                        = "https://www.googleapis.com/compute/v1/projects/<project-id>/zones/us-central1-b/networkEndpointGroups/ac-addin-pre-prod-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      },
    ]
      iap_config = {
      enabled               = true
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }
  },


# /******************************************
#         SMARTHUB-ADMIN NEG
# /******************************************/
  sh-admin-neg = {

    description                     = null
    protocol                        = "HTTP"
    port                            = 80
    port_name                       = "http"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = false
    compression_mode                = "DISABLED"
    security_policy                 = "upland-pre-prod-armor-rules"
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 80
      host                = null
      logging             = false
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

      groups = [
      {
        group                        = "projects/<project-id>/zones/us-central1-b/networkEndpointGroups/smarthub-admin-pre-prod-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      },
    ]
      iap_config = {
      enabled               = true
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }
  },

# /******************************************
#         SMARTHUB-UI NEG
# /******************************************/
  sh-ui-neg = {

    description                     = null
    protocol                        = "HTTP"
    port                            = 80
    port_name                       = "http"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = true
    compression_mode                = "DISABLED"
    security_policy                 = "upland-pre-prod-armor-rules"
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 80
      host                = null
      logging             = false
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

    cdn_policy = {
      cache_mode                   = "CACHE_ALL_STATIC"
      signed_url_cache_max_age_sec = 3600
      default_ttl                  = 3600
      client_ttl                   = 7200
      max_ttl                      = 10800
      serve_while_stale            = null
      cache_key_policy = {
        include_host          = true
        include_protocol      = true
        include_query_string  = true
        include_named_cookies = null
        include_http_headers  = null
      }
      negative_caching_policy = {
        code = null
        ttl  = null
      }
    }
      groups = [
      {
        group                        = "projects/<project-id>/zones/us-central1-b/networkEndpointGroups/smarthub-ui-pre-prod-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      },
    ]
    iap_config = {
      enabled               = false
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }     
  },

# /******************************************
#         ArgoCD NEG
# /******************************************/
argocd-pre-prod-neg = {

    description                     = null
    protocol                        = "HTTP"
    port                            = 80
    port_name                       = "http"
    timeout_sec                     = 30
    connection_draining_timeout_sec = 300
    enable_cdn                      = false
    compression_mode                = "DISABLED"
    security_policy                 = ""
    session_affinity                = null
    affinity_cookie_ttl_sec         = null
    custom_request_headers          = null
    custom_response_headers         = null

    health_check = {
      type                = "TCP"
      check_interval_sec  = 5
      timeout_sec         = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      request_path        = "/"  # health check path required
      port                = 80
      host                = null
      logging             = false
      proxy_header        = "NONE"
      response            = ""
      port_name           = ""
      request             = ""
      port_specification  = "USE_SERVING_PORT"
    }

    log_config = {
      enable      = false
      sample_rate = 0.0
    }

      groups = [
      {
        group                        = "projects/<project-id>/zones/us-central1-b/networkEndpointGroups/argocd-pre-prod-neg"
        balancing_mode               = "RATE"
        capacity_scaler              = 1.0
        description                  = null
        max_connections              = null
        max_connections_per_instance = null
        max_connections_per_endpoint = null
        max_rate                     = null
        max_rate_per_instance        = null
        max_rate_per_endpoint        = 10000
        max_utilization              = 1.0
      },
    ]
    iap_config = {
      enabled               = true
      oauth2_client_id     = ""
      oauth2_client_secret = ""
    }     
  }
  }
