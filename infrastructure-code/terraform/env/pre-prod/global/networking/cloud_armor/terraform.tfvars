project = "<project-id>"
name    = "main-armor-rules"
ip_ranges_rules = [
  {
    action         = "deny(403)",
    priority       = "2147483647",
    preview        = false
    versioned_expr = "SRC_IPS_V1",
    src_ip_ranges  = ["*"],
    description    = "Default rule, higher priority overrides it"
  },
  {
    action   = "allow",
    priority = "100",
    preview  = false,
    versioned_expr = "SRC_IPS_V1",
    src_ip_ranges = ["*"],
    description = "Allow all IP"
  },
  {
  action   = "allow",
  priority = "20",
  preview  = false,
  versioned_expr = "SRC_IPS_V1",
  src_ip_ranges = ["35.199.66.47/32", "35.198.18.224/32", "35.199.67.79/32", "35.198.36.209/32", "35.199.90.14/32", "35.199.123.150/32", "35.198.39.162/32", "35.199.77.186/32", "35.199.126.168/32", "104.155.77.122/32"],
  description = "Allow IP's from uptime checks (Google IPS)"
}
]



owasp_rules = {
  #https://cloud.google.com/armor/docs/rule-tuning#sql_injection_sqli
  rule_sqli = {
    action      = "deny(403)"
    priority    = "1000"
    description = "SQL injection"
    preview     = true

    ### Detect Level 1
    #expression  = "evaluatePreconfiguredExpr('sqli-stable',['owasp-crs-v030001-id942110-sqli','owasp-crs-v030001-id942120-sqli','owasp-crs-v030001-id942150-sqli','owasp-crs-v030001-id942180-sqli','owasp-crs-v030001-id942200-sqli','owasp-crs-v030001-id942210-sqli','owasp-crs-v030001-id942260-sqli','owasp-crs-v030001-id942300-sqli','owasp-crs-v030001-id942310-sqli','owasp-crs-v030001-id942330-sqli','owasp-crs-v030001-id942340-sqli','owasp-crs-v030001-id942380-sqli','owasp-crs-v030001-id942390-sqli','owasp-crs-v030001-id942400-sqli','owasp-crs-v030001-id942410-sqli','owasp-crs-v030001-id942430-sqli','owasp-crs-v030001-id942440-sqli','owasp-crs-v030001-id942450-sqli','owasp-crs-v030001-id942251-sqli','owasp-crs-v030001-id942420-sqli','owasp-crs-v030001-id942431-sqli','owasp-crs-v030001-id942460-sqli','owasp-crs-v030001-id942421-sqli','owasp-crs-v030001-id942432-sqli'])"

    ### Detect Level 1 & 2
    #expression  = "evaluatePreconfiguredExpr('sqli-stable',['owasp-crs-v030001-id942251-sqli','owasp-crs-v030001-id942420-sqli','owasp-crs-v030001-id942431-sqli','owasp-crs-v030001-id942460-sqli','owasp-crs-v030001-id942421-sqli','owasp-crs-v030001-id942432-sqli'])"

    ### Detect Level 1,2 & 3
    #expression  = "evaluatePreconfiguredExpr('sqli-stable',['owasp-crs-v030001-id942421-sqli','owasp-crs-v030001-id942432-sqli'])"

    ### Detect Level 1,2,3 & 4
    expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
  }
  #https://cloud.google.com/armor/docs/rule-tuning#cross-site_scripting_xss
  rule_xss = {
    action      = "deny(403)"
    priority    = "1001"
    description = "Cross-site scripting"
    preview     = true

    ### Detect Level 1
    #expression  = "evaluatePreconfiguredExpr('xss-stable',['owasp-crs-v030001-id941150-xss','owasp-crs-v030001-id941320-xss','owasp-crs-v030001-id941330-xss','owasp-crs-v030001-id941340-xss'])"

    ### Detect Level 1 & 2
    expression = "evaluatePreconfiguredExpr('xss-v33-stable')"
  }
  #https://cloud.google.com/armor/docs/rule-tuning#local_file_inclusion_lfi
  rule_lfi = {
    action      = "deny(403)"
    priority    = "1002"
    description = "Local file inclusion"
    preview     = true

    ### Detect Level 1
    expression = "evaluatePreconfiguredExpr('lfi-v33-stable')"
  }
  #https://cloud.google.com/armor/docs/rule-tuning#remote_code_execution_rce
  rule_rce = {
    action      = "deny(403)"
    priority    = "1003"
    description = "Remote code execution"
    preview     = true

    ### Detect Level 1
    expression = "evaluatePreconfiguredExpr('rce-v33-stable')"
  }
  #https://cloud.google.com/armor/docs/rule-tuning#remote_file_inclusion_rfi
  rule_rfi = {
    action      = "deny(403)"
    priority    = "1004"
    description = "Remote file inclusion"
    preview     = true

    ### Detect Level 1
    #expression  = "evaluatePreconfiguredExpr('rfi-stable', ['owasp-crs-v030001-id931130-rfi'])"

    ### Detect Level 1 & 2
    expression = "evaluatePreconfiguredExpr('rfi-v33-stable')"
  }
}

rate_rules = {
  #https://cloud.google.com/armor/docs/rule-tuning#sql_injection_sqli
  rule_login_attempts_policy = {
    action = "rate_based_ban"
    priority         = 1005
    description      = "Block requests (rate based)"
     src_ip_ranges = ["*"] # Adjust as needed
    preview          = true
    versioned_expr   = "SRC_IPS_V1"
    conform_action   = "allow"
    exceed_action    = "deny(403)"
    count            = 100
    interval_sec     = "300" # 5 minutes
    enforce_on_key   = "IP"
    ban_duration_sec = "60"
    preview     = true
  }
  rule_rate_limiting_api = {
    action = "throttle"
    priority         = 1006
    description      = "Block requests (throttle based)"
     src_ip_ranges = ["*"] # Adjust as needed
    preview          = true
    versioned_expr   = "SRC_IPS_V1"
    conform_action   = "allow"
    exceed_action    = "deny(403)"
    count            = 100
    interval_sec     = "300" # 5 minutes
    enforce_on_key   = "IP"
    ban_duration_sec = "0" # (optional)
    preview     = true
  }
}
