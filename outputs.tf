output "vnet_id" {
  value = module.networking.vnet_id
}

output "web_subnet_id" {
  value = module.networking.web_subnet_id
}

output "db_subnet_id" {
  value = module.networking.db_subnet_id
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "static_container_name" {
  value = module.storage.static_container_name
}
