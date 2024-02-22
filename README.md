# Azure Kubernetes Cluster Terraform module
Terraform module for creation of Azure Kubernetes Cluster

## Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_extension) | resource |
| [azurerm_kubernetes_cluster_node_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.attach_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_id"></a> [acr\_id](#input\_acr\_id) | Attach ACR ID to allow ACR Pull from the SP/Managed Indentity | `string` | `""` | no |
| <a name="input_analytics_destination_type"></a> [analytics\_destination\_type](#input\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_analytics_workspace_id"></a> [analytics\_workspace\_id](#input\_analytics\_workspace\_id) | Resource ID of Log Analytics Workspace | `string` | `null` | no |
| <a name="input_api_server_access_profile"></a> [api\_server\_access\_profile](#input\_api\_server\_access\_profile) | API server access profile | <pre>object({<br>    authorized_ip_ranges     = optional(list(string), [])<br>    subnet_id                = optional(string, null)<br>    vnet_integration_enabled = optional(bool, null)<br>  })</pre> | `null` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | The upgrade channel for this Kubernetes Cluster | `string` | `"stable"` | no |
| <a name="input_azure_active_directory_rbac"></a> [azure\_active\_directory\_rbac](#input\_azure\_active\_directory\_rbac) | Azure Active Directory RBAC configuration | <pre>object({<br>    tenant_id              = optional(string, null)<br>    admin_group_object_ids = optional(list(string), null)<br>    azure_rbac_enabled     = optional(bool, null)<br>    client_app_id          = optional(string, null)<br>    server_app_id          = optional(string, null)<br>    server_app_secret      = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Should the Azure Policy Add-On be enabled? | `bool` | `false` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | Default node pool configuration | <pre>object({<br>    name                         = string<br>    vm_size                      = string<br>    enable_auto_scaling          = optional(bool, false)<br>    type                         = optional(string, "VirtualMachineScaleSets")<br>    enable_host_encryption       = optional(bool, false)<br>    enable_node_public_ip        = optional(bool, false)<br>    max_pods                     = optional(string, null)<br>    node_labels                  = optional(object({}), {})<br>    node_taints                  = optional(list(string), [])<br>    only_critical_addons_enabled = optional(bool, false)<br>    os_disk_size_gb              = optional(string, null)<br>    os_disk_type                 = optional(string, "Managed")<br>    os_sku                       = optional(string, "Ubuntu")<br>    pod_subnet_id                = optional(string, null)<br>    scale_down_mode              = optional(string, null)<br>    max_surge                    = optional(string, null)<br>    vnet_subnet_id               = optional(string, null)<br>    zones                        = optional(list(string), null)<br>    max_count                    = optional(string, null)<br>    min_count                    = optional(string, null)<br>    node_count                   = string<br>  })</pre> | <pre>{<br>  "name": "default",<br>  "node_count": 1,<br>  "vm_size": "Standard_D2_v2"<br>}</pre> | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | The ID of the Disk Encryption Set which should be used for the Nodes and Volumes | `string` | `null` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix | `string` | n/a | yes |
| <a name="input_enable_attach_acr"></a> [enable\_attach\_acr](#input\_enable\_attach\_acr) | Enable ACR Pull attach. Needs acr\_id to be defined | `bool` | `false` | no |
| <a name="input_enable_azure_active_directory"></a> [enable\_azure\_active\_directory](#input\_enable\_azure\_active\_directory) | Enable Azure Active Directory Integration? | `bool` | `false` | no |
| <a name="input_enable_diagnostic_setting"></a> [enable\_diagnostic\_setting](#input\_enable\_diagnostic\_setting) | Enable diagnostic setting. var.analytics\_workspace\_id must be provided | `bool` | `false` | no |
| <a name="input_enable_role_based_access_control"></a> [enable\_role\_based\_access\_control](#input\_enable\_role\_based\_access\_control) | Is Role Based Access Control Enabled? | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | List of AKS extensions configuration | <pre>list(object({<br>    name           = string<br>    extension_type = string<br>    version        = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | Should HTTP Application Routing be enabled? | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of user assigned identity IDs | `list(string)` | `null` | no |
| <a name="input_key_vault_secret_rotation_enabled"></a> [key\_vault\_secret\_rotation\_enabled](#input\_key\_vault\_secret\_rotation\_enabled) | Should the secret store CSI driver on the AKS cluster be enabled? | `bool` | `false` | no |
| <a name="input_key_vault_secret_rotation_interval"></a> [key\_vault\_secret\_rotation\_interval](#input\_key\_vault\_secret\_rotation\_interval) | The interval to poll for secret rotation | `string` | `"2m"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window | <pre>list(object({<br>    day   = string<br>    hours = list(number)<br>  }))</pre> | <pre>[<br>  {<br>    "day": "Saturday",<br>    "hours": [<br>      1,<br>      2<br>    ]<br>  },<br>  {<br>    "day": "Sunday",<br>    "hours": [<br>      1,<br>      2<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | AKS name | `string` | n/a | yes |
| <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile) | Network configuration for AKS cluster | <pre>object({<br>    network_plugin = optional(string, null)<br>    network_policy = optional(string, null)<br>    pod_cidr       = optional(string, null)<br>    service_cidr   = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of node pools configuration | <pre>list(object({<br>    name                   = string<br>    vm_size                = string<br>    node_count             = string<br>    enable_auto_scaling    = optional(bool, false)<br>    enable_host_encryption = optional(bool, false)<br>    enable_node_public_ip  = optional(bool, false)<br>    max_pods               = optional(string, null)<br>    node_labels            = optional(object({}), {})<br>    node_taints            = optional(list(string), [])<br>    orchestrator_version   = optional(string, null)<br>    os_disk_size_gb        = optional(string, null)<br>    os_disk_type           = optional(string, null)<br>    os_type                = optional(string, null)<br>    priority               = optional(string, null)<br>    spot_max_price         = optional(number, null)<br>    os_sku                 = optional(string, null)<br>    pod_subnet_id          = optional(string, null)<br>    scale_down_mode        = optional(string, null)<br>    mode                   = optional(string, null)<br>    vnet_subnet_id         = optional(string, null)<br>    zones                  = optional(list(string), null)<br>    max_count              = optional(string, null)<br>    min_count              = optional(string, null)<br>    max_surge              = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | The name of the Resource Group where the Kubernetes Nodes should exist | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | Enable or Disable the OIDC issuer URL | `bool` | `false` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade) | `string` | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? | `bool` | `false` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this Kubernetes Cluster | `bool` | `true` | no |
| <a name="input_rbac_aad_managed"></a> [rbac\_aad\_managed](#input\_rbac\_aad\_managed) | Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration | `bool` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group name | `string` | n/a | yes |
| <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled) | Whether to enable run command for the cluster or not | `bool` | `true` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster | `string` | `"Free"` | no |
| <a name="input_storage_profile"></a> [storage\_profile](#input\_storage\_profile) | Storage drivers configuration | <pre>object({<br>    blob_driver_enabled         = optional(bool, false)<br>    disk_driver_enabled         = optional(bool, true)<br>    disk_driver_version         = optional(string, "v1")<br>    file_driver_enabled         = optional(bool, true)<br>    snapshot_controller_enabled = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | Specifies whether Azure AD Workload Identity should be enabled for the Cluster | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Client Certificate |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the Azure Kubernetes Managed Cluster |
| <a name="output_id"></a> [id](#output\_id) | The Kubernetes Managed Cluster ID |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | A kube\_admin\_config block. This is only available when Role Based Access Control with Azure Active Directory is enabled |
| <a name="output_kube_admin_config_raw"></a> [kube\_admin\_config\_raw](#output\_kube\_admin\_config\_raw) | Raw Kubernetes config for the admin account to be used by kubectl and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | A kube\_config block |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | Raw Kubernetes config to be used by kubectl and other compatible tools |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | A kubelet\_identity block |
| <a name="output_name"></a> [name](#output\_name) | The Kubernetes Managed Cluster name |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-linux-web-app/tree/main/LICENSE)