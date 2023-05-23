data "azurerm_monitor_diagnostic_categories" "this" {
  count       = var.enable_diagnostic_setting ? 1 : 0
  resource_id = azurerm_kubernetes_cluster.this.id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = var.enable_diagnostic_setting ? 1 : 0
  name                           = "aks-${var.project}-${var.env}-${var.location}-${var.name}"
  target_resource_id             = azurerm_kubernetes_cluster.this.id
  log_analytics_workspace_id     = var.analytics_workspace_id
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].metrics
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type] # TODO remove when issue is fixed: https://github.com/Azure/azure-rest-api-specs/issues/9281
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                              = "aks-${var.project}-${var.env}-${var.location}-${var.name}"
  location                          = var.location
  resource_group_name               = var.resource_group
  dns_prefix                        = var.dns_prefix
  automatic_channel_upgrade         = var.automatic_channel_upgrade
  azure_policy_enabled              = var.azure_policy_enabled
  kubernetes_version                = var.kubernetes_version
  private_cluster_enabled           = var.private_cluster_enabled
  oidc_issuer_enabled               = var.oidc_issuer_enabled
  workload_identity_enabled         = var.workload_identity_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  role_based_access_control_enabled = var.enable_role_based_access_control
  run_command_enabled               = var.run_command_enabled
  disk_encryption_set_id            = var.disk_encryption_set_id
  private_dns_zone_id               = var.private_dns_zone_id
  node_resource_group               = var.node_resource_group
  sku_tier                          = var.sku_tier
  http_application_routing_enabled  = var.http_application_routing_enabled
  tags = var.tags

  dynamic "oms_agent" {
    for_each = var.enable_diagnostic_setting ? [1] : []
    content {
      log_analytics_workspace_id = var.analytics_workspace_id
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.enable_role_based_access_control && var.enable_azure_active_directory && var.rbac_aad_managed ? [1] : []
    content {
      managed                = true
      tenant_id              = var.azure_active_directory_rbac.tenant_id
      admin_group_object_ids = var.azure_active_directory_rbac.admin_group_object_ids
      azure_rbac_enabled     = var.azure_active_directory_rbac.azure_rbac_enabled
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.enable_role_based_access_control && var.enable_azure_active_directory && !var.rbac_aad_managed ? [1] : []
    content {
      managed           = false
      tenant_id         = var.azure_active_directory_rbac.tenant_id
      client_app_id     = var.azure_active_directory_rbac.client_app_id
      server_app_id     = var.azure_active_directory_rbac.server_app_id
      server_app_secret = var.azure_active_directory_rbac.server_app_secret
    }
  }

  dynamic "api_server_access_profile" {
    for_each = var.api_server_access_profile == null ? [] : [1]
    content {
      authorized_ip_ranges     = var.api_server_access_profile.authorized_ip_ranges
      subnet_id                = var.api_server_access_profile.subnet_id
      vnet_integration_enabled = var.api_server_access_profile.vnet_integration_enabled
    }
  }

  default_node_pool {
    name                         = var.default_node_pool.name
    vm_size                      = var.default_node_pool.vm_size
    enable_auto_scaling          = var.default_node_pool.enable_auto_scaling
    type                         = var.default_node_pool.type
    enable_host_encryption       = var.default_node_pool.enable_host_encryption
    enable_node_public_ip        = var.default_node_pool.enable_node_public_ip
    max_pods                     = var.default_node_pool.max_pods
    node_labels                  = var.default_node_pool.node_labels
    node_taints                  = var.default_node_pool.node_taints
    only_critical_addons_enabled = var.default_node_pool.only_critical_addons_enabled
    os_disk_size_gb              = var.default_node_pool.os_disk_size_gb
    os_disk_type                 = var.default_node_pool.os_disk_type
    os_sku                       = var.default_node_pool.os_sku
    pod_subnet_id                = var.default_node_pool.pod_subnet_id
    scale_down_mode              = var.default_node_pool.scale_down_mode
    orchestrator_version         = var.orchestrator_version
    tags                         = var.tags
    vnet_subnet_id               = var.default_node_pool.vnet_subnet_id
    zones                        = var.default_node_pool.zones
    max_count                    = var.default_node_pool.enable_auto_scaling == true ? var.default_node_pool.max_count : null
    min_count                    = var.default_node_pool.enable_auto_scaling == true ? var.default_node_pool.min_count : null
    node_count                   = var.default_node_pool.node_count

    dynamic "upgrade_settings" {
      for_each = var.default_node_pool.max_surge == null ? [] : [1]
      content {
        max_surge = var.default_node_pool.max_surge
      }
    }
  }

  identity {
    type         = var.identity_ids == null ? "SystemAssigned" : "UserAssigned"
    identity_ids = var.identity_ids
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = var.key_vault_secret_rotation_enabled
    secret_rotation_interval = var.key_vault_secret_rotation_interval
  }

  maintenance_window {
    dynamic "allowed" {
      for_each = { for index, day in var.maintenance_window : day.day => day }
      content {
        day   = allowed.value.day
        hours = allowed.value.hours
      }
    }
  }

  dynamic "network_profile" {
    for_each = var.network_profile == null ? [] : [1]
    content {
      network_plugin = var.network_profile.network_plugin
      network_policy = var.network_profile.network_policy
      pod_cidr       = var.network_profile.pod_cidr
      service_cidr   = var.network_profile.service_cidr
    }
  }

  storage_profile {
    blob_driver_enabled         = var.storage_profile.blob_driver_enabled
    disk_driver_enabled         = var.storage_profile.disk_driver_enabled
    disk_driver_version         = var.storage_profile.disk_driver_version
    file_driver_enabled         = var.storage_profile.file_driver_enabled
    snapshot_controller_enabled = var.storage_profile.snapshot_controller_enabled
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].tags,      # At this time there's a bug in the AKS API where Tags for a Node Pool are not stored in the correct case
      default_node_pool[0].node_count # If AutoScaling is enabled, terraform will be trying to set initial node count
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = {
    for index, node_pool in var.node_pools : node_pool.name => node_pool
  }
  name                   = each.value.name
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.this.id
  vm_size                = each.value.vm_size
  node_count             = each.value.node_count
  enable_auto_scaling    = each.value.enable_auto_scaling
  enable_host_encryption = each.value.enable_host_encryption
  enable_node_public_ip  = each.value.enable_node_public_ip
  max_pods               = each.value.max_pods
  node_labels            = each.value.node_labels
  node_taints            = each.value.node_taints
  orchestrator_version   = each.value.orchestrator_version
  os_disk_size_gb        = each.value.os_disk_size_gb
  os_disk_type           = each.value.os_disk_type
  os_type                = each.value.os_type
  priority               = each.value.priority
  spot_max_price         = each.value.spot_max_price
  os_sku                 = each.value.os_sku
  pod_subnet_id          = each.value.pod_subnet_id
  scale_down_mode        = each.value.scale_down_mode
  mode                   = each.value.mode
  vnet_subnet_id         = each.value.vnet_subnet_id
  zones                  = each.value.zones
  max_count              = each.value.enable_auto_scaling == true ? each.value.max_count : null
  min_count              = each.value.enable_auto_scaling == true ? each.value.min_count : null
  tags                   = var.tags

  dynamic "upgrade_settings" {
    for_each = each.value.max_surge == null ? [] : [1]
    content {
      max_surge = each.value.max_surge
    }
  }

  lifecycle {
    ignore_changes = [
      node_count, # If AutoScaling is enabled, terraform will be trying to set initial node count
      tags        # At this time there's a bug in the AKS API where Tags for a Node Pool are not stored in the correct case
    ]
  }
}

resource "azurerm_role_assignment" "attach_acr" {
  count = var.enable_attach_acr ? 1 : 0
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

resource "azurerm_kubernetes_cluster_extension" "this" {
  for_each = {
    for index, extension in var.extensions : extension.name => extension
  }
  name           = each.value.name
  cluster_id     = azurerm_kubernetes_cluster.this.id
  extension_type = each.value.extension_type
  version        = each.value.version
}
