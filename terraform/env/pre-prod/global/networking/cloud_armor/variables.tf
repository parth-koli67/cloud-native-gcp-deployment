variable "name" {
  type        = string
  description = "The name of the security policy"
}

variable "project" {
  type        = string
  description = " The project in which the resource belongs. If it is not provided, the provider project is used"
}

variable "ip_ranges_rules" {
  type = list(object({
    action         = string
    priority       = string
    versioned_expr = string
    description    = string
    preview        = bool
    src_ip_ranges  = list(string)
  }))
  description = "The rules for configuring set of IP addresses or ranges"
  default     = null
}

variable "owasp_rules" {
  type = map(object({
    action      = string
    priority    = string
    description = string
    preview     = bool
    expression  = string
    })
  )
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
