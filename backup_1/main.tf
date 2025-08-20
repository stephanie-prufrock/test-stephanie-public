locals {
    tag_suffix = "${var.project}-${var.stage}"
    dr_region  = ( var.dr_region == null ? data.samsungcloudplatform_regions.myregion.regions[0].location :
                   length(var.dr_region) > 0 ? var.dr_region : data.samsungcloudplatform_regions.myregion.regions[0].location
                 )
}

data "samsungcloudplatform_regions" "myregion" {
}

data "samsungcloudplatform_region" "region" {
  filter {
    name = "location"
    values = [var.region]
  }
}

data "samsungcloudplatform_region" "dr_region" {
  filter {
    name = "location"
    values = [local.dr_region]
  }
}

resource "samsungcloudplatform_backup" "backup" {
  backup_name                 = var.name
  backup_policy_type_category = var.category
  backup_repository           = var.repository
  object_id                   = var.object_id
  object_type                 = var.object_type
  policy_type                 = var.policy_type
  product_names               = var.product_names

  retention_period             = var.retention_period
  incremental_retention_period = var.incremental_retention_period
  service_zone_id              = data.samsungcloudplatform_region.region.id

  is_backup_dr_enabled         = var.dr_enabled
  is_backup_dr_destroy_enabled = var.dr_destroy_enabled
  backup_dr_zone_id            = (var.dr_enabled) == "Y" ? data.samsungcloudplatform_region.dr_region.id : null

  dynamic "schedules" {
    for_each = var.schedules
    content {
      schedule_frequency = schedules.value["schedule_frequency"]
      schedule_frequency_detail = schedules.value["schedule_frequency_detail"]
      schedule_type = schedules.value["schedule_type"]
      start_time = schedules.value["start_time"]
    }
  }

  tags = var.tags
}

