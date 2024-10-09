/**
 * # Main title
 *
 * Azure Private DNS zone
 *
 * Module to deploy Azure Private DNS zone
 */

resource "azurerm_private_dns_zone" "private" {
  name                = var.name
  resource_group_name = var.resource_group

  tags = var.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["created_at"]
    ]
  }
}