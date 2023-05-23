output "name" {
  description = "The Kubernetes Managed Cluster name"
  value       = azurerm_kubernetes_cluster.this.name
}

output "id" {
  description = "The Kubernetes Managed Cluster ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "private_fqdn" {
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.this.private_fqdn
}

output "kube_admin_config" {
  description = "A kube_admin_config block. This is only available when Role Based Access Control with Azure Active Directory is enabled"
  value       = azurerm_kubernetes_cluster.this.kube_admin_config
  sensitive   = true
}

output "kube_admin_config_raw" {
  description = "Raw Kubernetes config for the admin account to be used by kubectl and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled"
  value       = azurerm_kubernetes_cluster.this.kube_admin_config_raw
  sensitive   = true
}

output "kube_config" {
  description = "A kube_config block"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools"
  sensitive   = true
}

output "client_certificate" {
  description = "Client Certificate"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  sensitive   = true
}

output "kubelet_identity" {
  description = "A kubelet_identity block"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
}
