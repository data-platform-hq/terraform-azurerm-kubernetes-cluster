variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
}

variable "name" {
  type        = string
  description = "AKS name"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix"
}


variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}

variable "identity_ids" {
  type        = list(string)
  description = "List of user assigned identity IDs"
  default     = null
}

variable "automatic_channel_upgrade" {
  type        = string
  description = "The upgrade channel for this Kubernetes Cluster"
  default     = "stable"
}

variable "azure_policy_enabled" {
  type        = bool
  description = "Should the Azure Policy Add-On be enabled?"
  default     = false
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = null
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
  default     = false
}

variable "oidc_issuer_enabled" {
  type        = bool
  description = "Enable or Disable the OIDC issuer URL"
  default     = false
}

variable "workload_identity_enabled" {
  type        = bool
  description = "Specifies whether Azure AD Workload Identity should be enabled for the Cluster"
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this Kubernetes Cluster"
  default     = true
}

variable "run_command_enabled" {
  type        = bool
  description = "Whether to enable run command for the cluster or not"
  default     = true
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster"
  default     = "Free"
}

variable "api_server_access_profile" {
  type = object({
    authorized_ip_ranges     = optional(list(string), [])
    subnet_id                = optional(string, null)
    vnet_integration_enabled = optional(bool, null)
  })
  description = "API server access profile"
  default     = null
}

variable "enable_role_based_access_control" {
  type        = bool
  description = "Is Role Based Access Control Enabled?"
  default     = true
}

variable "enable_azure_active_directory" {
  type        = bool
  description = "Enable Azure Active Directory Integration?"
  default     = false
}

variable "rbac_aad_managed" {
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration"
  type        = bool
  default     = false
}

variable "azure_active_directory_rbac" {
  type = object({
    tenant_id              = optional(string, null)
    admin_group_object_ids = optional(list(string), null)
    azure_rbac_enabled     = optional(bool, null)
    client_app_id          = optional(string, null)
    server_app_id          = optional(string, null)
    server_app_secret      = optional(string, null)
  })
  description = "Azure Active Directory RBAC configuration"
  default     = null
}

variable "default_node_pool" {
  type = object({
    name                         = string
    vm_size                      = string
    enable_auto_scaling          = optional(bool, false)
    type                         = optional(string, "VirtualMachineScaleSets")
    enable_host_encryption       = optional(bool, false)
    enable_node_public_ip        = optional(bool, false)
    max_pods                     = optional(string, null)
    node_labels                  = optional(object({}), {})
    node_taints                  = optional(list(string), [])
    only_critical_addons_enabled = optional(bool, false)
    os_disk_size_gb              = optional(string, null)
    os_disk_type                 = optional(string, "Managed")
    os_sku                       = optional(string, "Ubuntu")
    pod_subnet_id                = optional(string, null)
    scale_down_mode              = optional(string, null)
    max_surge                    = optional(string, null)
    vnet_subnet_id               = optional(string, null)
    zones                        = optional(list(string), null)
    max_count                    = optional(string, null)
    min_count                    = optional(string, null)
    node_count                   = string
  })
  description = "Default node pool configuration"
  default = {
    name       = "default"
    vm_size    = "Standard_D2_v2"
    node_count = 1
  }
}

variable "key_vault_secret_rotation_enabled" {
  type        = bool
  description = "Should the secret store CSI driver on the AKS cluster be enabled?"
  default     = false
}

variable "key_vault_secret_rotation_interval" {
  type        = string
  description = "The interval to poll for secret rotation"
  default     = "2m"
}

variable "maintenance_window" {
  type = list(object({
    day   = string
    hours = list(number)
  }))
  description = "Maintenance window"
  default = [
    {
      day   = "Saturday",
      hours = [1, 2]
    },
    {
      day   = "Sunday",
      hours = [1, 2]
    }
  ]
}

variable "network_profile" {
  type = object({
    network_plugin = optional(string, null)
    network_policy = optional(string, null)
    pod_cidr       = optional(string, null)
    service_cidr   = optional(string, null)
  })
  description = "Network configuration for AKS cluster"
  default     = null
}

variable "storage_profile" {
  type = object({
    blob_driver_enabled         = optional(bool, false)
    disk_driver_enabled         = optional(bool, true)
    disk_driver_version         = optional(string, "v1")
    file_driver_enabled         = optional(bool, true)
    snapshot_controller_enabled = optional(bool, true)
  })
  description = "Storage drivers configuration"
  default     = {}
}

variable "analytics_workspace_id" {
  type        = string
  description = "Resource ID of Log Analytics Workspace"
  default     = null
}

variable "analytics_destination_type" {
  type        = string
  description = "Possible values are AzureDiagnostics and Dedicated"
  default     = "Dedicated"
}

variable "enable_diagnostic_setting" {
  type        = bool
  description = "Enable diagnostic setting. var.analytics_workspace_id must be provided"
  default     = false
}

variable "disk_encryption_set_id" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used for the Nodes and Volumes"
  default     = null
}

variable "private_dns_zone_id" {
  type        = string
  description = "Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None"
  default     = null
}

variable "node_resource_group" {
  type        = string
  description = "The name of the Resource Group where the Kubernetes Nodes should exist"
  default     = null
}

variable "http_application_routing_enabled" {
  type        = bool
  description = "Should HTTP Application Routing be enabled?"
  default     = false
}

variable "enable_attach_acr" {
  description = "Enable ACR Pull attach. Needs acr_id to be defined"
  type        = bool
  default     = false
}

variable "acr_id" {
  description = "Attach ACR ID to allow ACR Pull from the SP/Managed Indentity"
  type        = string
  default     = ""
}

variable "orchestrator_version" {
  type        = string
  description = "Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
  default     = null
}

variable "node_pools" {
  type = list(object({
    name                   = string
    vm_size                = string
    node_count             = string
    enable_auto_scaling    = optional(bool, false)
    enable_host_encryption = optional(bool, false)
    enable_node_public_ip  = optional(bool, false)
    max_pods               = optional(string, null)
    node_labels            = optional(object({}), {})
    node_taints            = optional(list(string), [])
    orchestrator_version   = optional(string, null)
    os_disk_size_gb        = optional(string, null)
    os_disk_type           = optional(string, null)
    os_type                = optional(string, null)
    priority               = optional(string, null)
    spot_max_price         = optional(number, null)
    os_sku                 = optional(string, null)
    pod_subnet_id          = optional(string, null)
    scale_down_mode        = optional(string, null)
    mode                   = optional(string, null)
    vnet_subnet_id         = optional(string, null)
    zones                  = optional(list(string), null)
    max_count              = optional(string, null)
    min_count              = optional(string, null)
    max_surge              = optional(string, null)
  }))
  description = "List of node pools configuration"
  default     = []
}

variable "extensions" {
  type = list(object({
    name           = string
    extension_type = string
    version        = optional(string, null)
  }))
  description = "List of AKS extensions configuration"
  default     = []
}
