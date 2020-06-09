resource "azurerm_monitor_autoscale_setting" "example" {
  name = "myAutoscaleSetting"
  resource_group_name = var.resource_group_name
  location = var.location
  target_resource_id = azurerm_virtual_machine_scale_set.vmss.id

  profile {
      name = "defaultProfile"
      capacity {
          default = 2
          minimum = 2
          maximum = 10
      }
      rule {
          metric_trigger {
              matric_name = "Percentage CPU"
              metric_resource_id = azurerm_virtual_machine_scale_set.vmss.id
              time_grain = "PT1M"
              statistic = "Average"
              time_window = "PT5M"
              time_aggregation = "Average"
              operator = "GreaterThan"
              threshold = 40
          }

          scale_action {
              direction = "Increase"
              type = "ChangeCount"
              value = "1"
              cooldown = "PT10M"
          }
      }

      rule {
          metric_trigger {
              metric_name = "Percentage CPU"
              metric_resource_id = azurerm_virtual_machine_scale_set.vmss.id
              time_grain = "PT1M"
              statistic = "Average"
              time_window = "PT5M"
              time_aggregation = "Average"
              operator = "LessThan"
              threshold = 20
          }

          scale_action {
              direction = "Decrease"
              type = "ChangeCount"
              value = "1"
              cooldown = "PT10M"
          }
      }
   }
}
