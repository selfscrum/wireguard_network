output "wireguard_server_ip" {
  value       = hcloud_server.wireguard.ipv4_address
  description = "The host IP of the wireguard server"
}
