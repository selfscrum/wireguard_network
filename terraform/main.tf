terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.13"
}

variable "access_token" {}
variable "env_name"  { }
variable "env_stage" { }
variable "location" { }
variable "system_function" {}
variable "wireguard_image" {}
variable "instance_type" {}
variable "keyname" {} 
variable "network_zone" {}

provider "hcloud" {
  token = var.access_token
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE WIREGUARD SERVER
# ---------------------------------------------------------------------------------------------------------------------

module "wireguard_server" {
  source = "../modules/wireguard_server"
  cluster_name      = format("%s-%s-server",var.env_stage, var.env_name)
  cluster_size      = var.num_servers
  image             = var.consul_image
  server_type       = var.consul_type
  location          = var.location
  labels            = {
                      "Name"   = var.env_name
                      "Stage"  = var.env_stage
  }
  ssh_key           = var.keyname
  network_id        = data.terraform_remote_state.network.outputs.network_id
  private_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_id
  user_data         = templatefile (
# ---------------------------------------------------------------------------------------------------------------------
# THE MULTIPART/MIXED USER DATA SCRIPT THAT WILL RUN ON EACH CONSUL SERVER INSTANCE WHEN IT'S BOOTING
# This script will provide some basic hardening and configure and start Consul
# ---------------------------------------------------------------------------------------------------------------------
                      "${path.module}/user-data-server.mm",
                        {
                        hcloud_token             = var.access_token,
                        cluster_tag_key          = var.env_name,
                        cluster_tag_value        = "0",
                        }
                      )
}
