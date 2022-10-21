####################################################################################
#  PROVIDERS
# ##################################################################################   
provider "azurerm" {
  # Always run terraform init -upgrade to obtain latest version of AzureRM Provider

  subscription_id            = var.subscriptionId
  tenant_id                  = var.tenantId
  client_id                  = var.clientId
  client_secret              = var.clientSecret
  skip_provider_registration = true
  features {}
}

provider "null" {
  # version = "~> 2.1"
}

provider "azurerm" {
  alias           = "dev"
  subscription_id = var.devSubscriptionId
  features {}
}

####################################################################################
#  DATA
# ##################################################################################
data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "dev-bashpty-rg-pa" {
  provider = azurerm.dev
  name     = "dev-bashpty-rg-pa"
}

####################################################################################
#  RESOURCE GROUP
# ##################################################################################
resource "azurerm_resource_group" "bashpty-rg" {
  name     = "${var.environment}-${var.resourceGroupName}-${var.country}"
  location = var.location

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Project     = var.project
    CostCenter  = var.country
    Environment = var.environment
    Squad       = var.inventory
    Createdby   = var.terraform
  }
}
####################################################################################
#  OUTPUTS DEV
# ##################################################################################
output "rg_name_dev" {
  value = data.azurerm_resource_group.dev-bashpty-rg-pa.name
}
####################################################################################
#  TERRAFORM STATE BACKEND
# ##################################################################################
terraform {
  backend "azurerm" {
    resource_group_name  = "dev-bashpty-rg-pa"
    storage_account_name = "bashptytfstatedev"
    container_name       = "tfstate-container"
    key                  = "terraform-dev.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.27.0"
    }
  }
}
# Storage Account for the Terraform State File
resource "azurerm_storage_account" "terraform-state" {
  name                      = var.terraformstatestorage
  resource_group_name       = azurerm_resource_group.bashpty-rg.name
  location                  = azurerm_resource_group.bashpty-rg.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  access_tier               = "Hot"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Project     = var.project
    CostCenter  = var.country
    Environment = var.environment
    Squad       = var.inventory
    Createdby   = var.terraform
  }
}

# Storage Container for the Core State File
resource "azurerm_storage_container" "tfstate-container" {
  name                 = "tfstate-container"
  storage_account_name = azurerm_storage_account.terraform-state.name
}