variable "name" {
  type = string
  description = "The name of the security policy"
}

variable "project" {
  type = string
  description = " The project in which the resource belongs. If it is not provided, the provider project is used"
}

variable "ip_ranges_rules" {
  type = list(object({
    action          = string
    priority        = string
    versioned_expr  = string
    description     = string
    preview         = bool
    src_ip_ranges   = list(string)
  }))
  description = "The rules for configuring set of IP addresses or ranges"
  default = null
}
# --------------------------------- 
# OWASP top 10 rules
# --------------------------------- 
variable "owasp_rules" {
     type = map(object({
        action                              = string
        priority                            = string
        expression                          = string
        description                         = string
        preview                             = bool
        })
    )
    } 

# --------------------------------- 
# Rate-limiting rule block
# --------------------------------- 
variable "throttle_rules" {
  default = null
  
    type = map(object({
        action                              = string
        priority                            = string
        description                         = string
        preview                             = bool
        versioned_expr                      = string
        # expression                          = string
        src_ip_ranges_throttle              = list(string)
        conform_action                      = string
        exceed_action                       = string
        count                               = number
        interval_sec                        = number
        })
    )
}  

variable "layer_7_ddos_defense_enable" {
  description = "(Optional) If set to true, enables Cloud Armor Adaptive Protection for L7 DDoS detection. Cloud Armor Adaptive Protection is only supported in Global Security Policies of type CLOUD_ARMOR. Set this variable `true` for Adaptive Protection Auto Deploy."
  type        = bool
  default     = false
}

variable "layer_7_ddos_defense_rule_visibility" {
  description = "(Optional) Rule visibility can be one of the following: STANDARD - opaque rules. PREMIUM - transparent rules. This field is only supported in Global Security Policies of type CLOUD_ARMOR."
  type        = string
  default     = "STANDARD"
}

variable "adaptive_protection_auto_deploy" {
  description = "Configuration for Automatically deploy Cloud Armor Adaptive Protection suggested rules. `priority` and `action` fields are required if `enable` is set to true. Requires `layer_7_ddos_defense_enable` set to `true`."
  type = object({
    enable                      = bool
    priority                    = optional(number, null)
    action                      = optional(string, null)
    preview                     = optional(bool, false)
    description                 = optional(string, "Adaptive Protection auto-deploy")
    load_threshold              = optional(number)
    confidence_threshold        = optional(number)
    impacted_baseline_threshold = optional(number)
    expiration_sec              = optional(number)
    redirect_type               = optional(string)
    redirect_target             = optional(string)

    rate_limit_options = optional(object({
      enforce_on_key      = optional(string)
      enforce_on_key_name = optional(string)

      enforce_on_key_configs = optional(list(object({
        enforce_on_key_name = optional(string)
        enforce_on_key_type = optional(string)
      })))

      exceed_action                        = optional(string)
      rate_limit_http_request_count        = optional(number)
      rate_limit_http_request_interval_sec = optional(number)
      ban_duration_sec                     = optional(number)
      ban_http_request_count               = optional(number)
      ban_http_request_interval_sec        = optional(number)
    }), {})
  })

  default = {
    enable = false
  }
}

variable "type" {
  description = "Type indicates the intended use of the security policy. Possible values are CLOUD_ARMOR and CLOUD_ARMOR_EDGE."
  type        = string
  default     = "CLOUD_ARMOR"
}

variable "rate_rules" {
  type = map(object({
    action           = optional(string)
    priority         = optional(string)
    expression       = optional(string)
    description      = optional(string)
    preview          = optional(bool)
    versioned_expr   = optional(string)
    src_ip_ranges    = optional(list(string))
    conform_action   = optional(string)
    exceed_action    = optional(string)
    count            = optional(number)
    interval_sec     = optional(number)
    enforce_on_key   = optional(string)
    ban_duration_sec = optional(number)
    })
  )
}
