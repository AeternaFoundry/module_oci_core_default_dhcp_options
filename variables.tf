variable "core_default_dhcp_options" {
  description = <<EOT
Map of core_default_dhcp_options, attributes below
Required:
    - manage_default_resource_id
    - options (block):
        - custom_dns_servers (optional)
        - search_domain_names (optional)
        - server_type (optional)
        - type (required)
Optional:
    - compartment_id
    - defined_tags
    - display_name
    - domain_name_type
    - freeform_tags
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    manage_default_resource_id = string
    compartment_id             = optional(string)
    defined_tags               = optional(map(string))
    display_name               = optional(string)
    domain_name_type           = optional(string)
    freeform_tags              = optional(map(string))
    options = list(object({
      custom_dns_servers  = optional(list(string))
      search_domain_names = optional(list(string))
      server_type         = optional(string)
      type                = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.core_default_dhcp_options : (
        length(v.options) >= 1
      )
    ])
    error_message = "Each options list must contain at least 1 items"
  }
}

