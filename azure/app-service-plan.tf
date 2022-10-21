####################################################################################
#  BASHPTY APP SERVICE PLAN DEV
#################################################################################### 
resource "azurerm_service_plan" "bashpty-appservice-plan-pa-dev" {
  name                = "bashpty-appservice-plan-pa-dev"
  resource_group_name = azurerm_resource_group.bashpty-rg.name
  location            = var.location2
  os_type             = "Linux"
  sku_name            = "B2"
  tags = {
    Project     = var.project
    CostCenter  = var.country
    Environment = var.environment
    Squad       = var.inventory
    Createdby   = var.terraform
  }
}
