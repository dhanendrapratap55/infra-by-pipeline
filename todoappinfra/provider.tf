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
    subscription_id = "9f2fc162-8625-4e93-8616-a608f22e0f7e"
}
