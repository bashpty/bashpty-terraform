####################################################################################
#                                 ### VARIABLES ###                                     
# ##################################################################################

####################################################################################
#  MAIN VARIABLES
# ##################################################################################

variable "subscriptionId" {
  description = "Subscription ID"
}
variable "tenantId" {
  description = "Tenant ID"
}
variable "clientId" {
  description = "Client ID"
}
variable "clientSecret" {
  description = "Client secret"
  sensitive   = true
}
variable "country" {
  description = "Country code"
}
variable "resourceGroupName" {
  description = "Resource group name"
}

variable "devSubscriptionId" {
  description = "Dev Subscription ID"
}


####################################################################################
#  TAG VARIABLES
# ##################################################################################
variable "environment" {
  description = "Environment"
}
variable "location" {
  description = "Location"
  default     = "West US"
}

variable "location2" {
  description = "Location"
  default     = "East Us"
}

variable "project" {
  description = "Project"
}

variable "inventory" {
  description = "master-inventory"
}
variable "terraform" {
  description = "Created by Terraform SPN"
}

####################################################################################
#  STATIC WEBSITE - STORAGE ACCOUNT VARIABLES
# ##################################################################################
variable "terraformstatestorage" {
  description = "Terraform State File"
}

####################################################################################
#  POSTGRESSQL VARIABLES
# ##################################################################################
variable "adminUsernameSqldb" {
  description = "The administrator login name for the new server."
}

variable "adminPasswordSqldb" {
  description = "The password associated with the administrator_login user."
}

####################################################################################
#  APP SERVICES VARIABLES
# ##################################################################################

variable "acrPassword-dev" {
 description = "Password for Development Azure Container Registry."
}

variable "acrLoginServer-dev" {
 description = "LogingServer for Development Azure Container Registry."
}

variable "acrUserName-dev" {
 description = "Username for Development Azure Container Registry."
}

variable "SqlConnectionDb-dev" {
 description = "Connection String for Postgres"
}

