####################################################################################
#  AZURE CONTAINER REGISTRY
# ################################################################################## 

resource "azurerm_container_registry" "bashptyregistrydev" {
  name                = "bashptyregistrydev"
  resource_group_name = azurerm_resource_group.bashpty-rg.name
  location            = azurerm_resource_group.bashpty-rg.location
  sku                 = "Basic"
  admin_enabled       = "true"


  tags = {
    Project     = var.project
    CostCenter  = var.country
    Environment = var.environment
    Squad       = var.inventory
    Createdby   = var.terraform
  }

}
