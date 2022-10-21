# ####################################################################################
# #  POSTGRESQL SERVER
# # ##################################################################################
resource "azurerm_postgresql_server" "bashpty-postgresql-server" {
  name                = "${var.environment}-bashpty-postgresql-server-${var.country}"
  resource_group_name = azurerm_resource_group.bashpty-rg.name
  location            = var.location2

  administrator_login    = var.adminUsernameSqldb
  administrator_login_password = var.adminPasswordSqldb

  storage_mb = 20480
  sku_name   = "B_Gen5_1"
  version    = "11"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  tags = {
    Project     = var.project
    CostCenter  = var.country
    Environment = var.environment
    Squad       = var.inventory
    Createdby   = var.terraform
  }
}
