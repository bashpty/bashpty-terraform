####################################################################################
#  LIFE WEB APP SERVICE
#################################################################################### 
resource "azurerm_linux_web_app" "master-inventory-mvc" {
  name                = "master-inventory-mvc"
  resource_group_name = azurerm_resource_group.bashpty-rg.name
  location            = var.location2
  service_plan_id     = azurerm_service_plan.bashpty-appservice-plan-pa-dev.id
  https_only          = true
  enabled             = true
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_REGISTRY_SERVER_URL          = var.acrLoginServer-dev
    DOCKER_REGISTRY_SERVER_USERNAME     = var.acrUserName-dev
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.acrPassword-dev
  }
  connection_string {
    name  = "Database"
    type  = "PostgreSQL"
    value = var.SqlConnectionDb-dev
  }
  lifecycle {
    ignore_changes = [
      app_settings,
    ]
  }
  site_config {
    always_on = true
    ftps_state                = "FtpsOnly"
    managed_pipeline_mode     = "Integrated"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Project     = var.project
    CostCenter  = var.country
    Environment = var.environment
    Squad       = var.inventory
  }
}
####################################################################################
#  LIFE WEB DEVELOPMENT SLOT
#################################################################################### 
# resource "azurerm_linux_web_app_slot" "master-inventory-mvc-dev" {
#   name                = "dev"
#   app_service_id = azurerm_linux_web_app.master-inventory-mvc.id

#   https_only          = true
#   enabled             = true
#   app_settings = {
#     WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
#     DOCKER_REGISTRY_SERVER_URL          = var.acrLoginServer-dev
#     DOCKER_REGISTRY_SERVER_USERNAME     = var.acrUserName-dev
#     DOCKER_REGISTRY_SERVER_PASSWORD     = var.acrPassword-dev
#   }
#   connection_string {
#     name  = "Database"
#     type  = "PostgreSQL"
#     value = var.SqlConnectionDb-dev
#   }
#   lifecycle {
#     ignore_changes = [
#       app_settings,
#     ]
#   }
#   site_config {
#     managed_pipeline_mode = "Integrated"
#   }
#   identity {
#     type = "SystemAssigned"
#   }
#   tags = {
#     Project     = var.project
#     CostCenter  = var.country
#     Environment = var.environment
#     Squad       = var.inventory
#   }
# }