resource "google_compute_security_policy" "policy" {
  name    = var.name
  project = var.project

  dynamic "rule" {
    for_each = var.ip_ranges_rules != null ? var.ip_ranges_rules : toset([])
    content {
      action      = rule.value.action
      description = rule.value.description
      priority    = rule.value.priority
      preview     = rule.value.preview

      match {
        versioned_expr = rule.value.versioned_expr

        config {
          src_ip_ranges = rule.value.src_ip_ranges
        }
      }
    }
  }

  # --------------------------------- 
  # OWASP top 10 rules
  # --------------------------------- 

  dynamic "rule" {
    for_each = var.owasp_rules
    content {
      action      = rule.value.action
      description = rule.value.description
      priority    = rule.value.priority
      preview     = rule.value.preview

      match {
        expr {
          expression = rule.value.expression
        }
      }
    }
  }


  # --------------------------------- 
  # DDOS Protection
  # ---------------------------------


  dynamic "adaptive_protection_config" {
    for_each = var.layer_7_ddos_defense_enable && var.type != "CLOUD_ARMOR_EDGE" ? ["adaptive_protection_config"] : []
    content {
      layer_7_ddos_defense_config {
        enable          = var.layer_7_ddos_defense_enable
        rule_visibility = var.layer_7_ddos_defense_rule_visibility
      }
      # dynamic "auto_deploy_config" {
      #   for_each = var.adaptive_protection_auto_deploy.enable ? { auto_deploy = var.adaptive_protection_auto_deploy } : {}
      #   content {
      #     load_threshold              = auto_deploy_config.value["load_threshold"]
      #     confidence_threshold        = auto_deploy_config.value["confidence_threshold"]
      #     impacted_baseline_threshold = auto_deploy_config.value["impacted_baseline_threshold"]
      #     expiration_sec              = auto_deploy_config.value["expiration_sec"]
      #   }

      # }
    }
  }
  dynamic "rule" {
    for_each = var.rate_rules
    content {
      action      = rule.value.action
      description = rule.value.description
      priority    = rule.value.priority
      preview     = rule.value.preview

      match {
        versioned_expr = rule.value.versioned_expr != "" ? rule.value.versioned_expr : null
        dynamic "config" {
          for_each = length(coalesce(rule.value.src_ip_ranges, [])) > 0 ? [rule.value] : []
          content {
            src_ip_ranges = rule.value.src_ip_ranges
          }
        }
      }
      rate_limit_options {
        conform_action = rule.value.conform_action
        exceed_action  = rule.value.exceed_action
        rate_limit_threshold {
          count        = rule.value.count
          interval_sec = rule.value.interval_sec
        }
        enforce_on_key   = rule.value.enforce_on_key
        ban_duration_sec = rule.value.ban_duration_sec
      }
    }
  }
}

