# data "azurerm_kubernetes_cluster" "this" {
#   name                = "tutorial8875-aks"
#   resource_group_name = "tutorial8875-rsg"
# }

# output "aks_fqdn" {
#   value = data.azurerm_kubernetes_cluster.this.fqdn
# }
