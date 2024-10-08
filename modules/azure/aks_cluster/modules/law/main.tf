/**
 * # Main title
 *
 * Azure Log Analytics Workspace
 *
 * Module to deploy Azure  Log Analytics Workspace
 */

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name}-law"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = var.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["created_at"]
    ]
  }
}