terraform {
  required_providers {
    azurerm = {
      source                   = "hashicorp/azurerm"
      version                  = "=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name      = "tf-storage-rg"
    storage_account_name     = "azpipelineterrastorage"
    container_name           = "tfstate"
    key                      = "terraform.tfstate"
    
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}



# Create a resource group
resource "azurerm_resource_group" "tf_rg" {
  name                        = "az-pipeline-terra-rg"
  location                    = "East US"
}

resource "azurerm_container_group" "tf_cg"{
  name                        = "weatherapi"
  location                    = azurerm_resource_group.tf_rg.location
  resource_group_name         = azurerm_resource_group.tf_rg.name

  ip_address_type             = "Public"
  dns_name_label              = "semotapis"
  os_type                     = "Linux"

  container{
    name                      = "weatherapi"
    image                     = "sbeyou/semotapi"
      cpu                     = "1"
      memory                  = "1"

      ports{
        port                  = 80
        protocol              = "TCP"
          }
    }
}
