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
variable "subnet" {}
variable "local_domain" {}

provider "hcloud" {
  token = var.access_token
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE WIREGUARD SERVER
# ---------------------------------------------------------------------------------------------------------------------

module "wireguard_server" {
  source = "modules/wireguard_server"
  cluster_name      = format("%s-%s-server",var.env_stage, var.env_name)
  image             = var.wireguard_image
  server_type       = var.instance_type
  location          = var.location
  labels            = {
                      "Name"   = var.env_name
                      "Stage"  = var.env_stage
  }
  ssh_key           = var.keyname
  user_data         = templatefile (
# ---------------------------------------------------------------------------------------------------------------------
# THE MULTIPART/MIXED USER DATA SCRIPT THAT WILL RUN ON EACH WIREGUARD SERVER INSTANCE WHEN IT'S BOOTING
# ---------------------------------------------------------------------------------------------------------------------
                      "${path.module}/user-data-server.mm",
                        {
                        hcloud_token             = var.access_token,
                        subnet                   = var.subnet,
                        domain                   = var.local_domain,
                        cluster_tag_key          = var.env_name,
                        cluster_tag_value        = "0",
                        }
                      )
}
