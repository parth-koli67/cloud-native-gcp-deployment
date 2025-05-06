
/******************************************
  Details of Compute Engine
 *****************************************/

module "compute_instance" {
  source                  = "../../../../modules/compute-engine/linux-vm/"
  for_each                = var.compute_instance
  project                 = each.value.project_id
  region                  = each.value.region
  instance_count          = each.value.instance_count
  machine_name            = each.value.machine_name
  vm_description          = each.value.vm_description
  enable_external_ip      = each.value.enable_external_ip
  generate_internal_ip    = each.value.generate_internal_ip
  internal_ip_address     = each.value.internal_ip_address
  machine_type            = each.value.machine_type
  zone                    = each.value.machine_zone
  instance_labels         = each.value.instance_labels
  vm_deletion_protect     = each.value.vm_deletion_protect
  instance_image_selflink = each.value.instance_image_selflink
  network                 = each.value.network
  subnetwork              = each.value.subnetwork
  network_tags            = each.value.network_tags
  boot_disk_info          = each.value.boot_disk0_info
  service_account         = each.value.service_account
}
