terraform {

    required_providers {

        azurerm = {
            source= "hashicorp/azurerm"
            version = "=3.0.0"       
            }
    }
}

provider"azurerm" {

    features {}
    subscription_id = "51b6ad96-2bb6-48e5-b566-1d3406221d56"
}
