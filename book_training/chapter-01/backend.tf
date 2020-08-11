terraform {
    backend "azurerm" {
        storage_account_name = "tfstatecapter01"
        container_name = "tfstate"
        key = "terraform.tfstate"
        access_key = "N1j8kto7fxQrnQvvf/6huB9frzuun/aKhN/DuPd5dfWAvwnuNWWZdL0M37iV/nIAbagjXLFmZ7Z27Cqsskr6+w=="
    }
}