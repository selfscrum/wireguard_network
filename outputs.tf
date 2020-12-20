# only needed for module registry, otherwise empty

output "server_ipv4_address" {
  value       = module.wireguard_server.wireguard_server_ip
  description = "The host IP of the wireguard server"
}

output "server_name" {
  value       = format("%s-%s-server",var.env_stage, var.env_name)
  description = "The host name of the wireguard server"
}

output "subnet" {
  value       = var.subnet
  description = "The subnet managed by this wireguard server"
}
