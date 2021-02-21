# wireguard_network

Terraform Module to create a Wireguard-driven network within Terraform Cloud, based on Hetzner Cloud resources.
The server contains a Wireguard Server and an Unbound server as the local DNS.

Service interface still under construction, but an initial server should be readibly configurable.

Documentation is sparse. 

## Prerequisites

* have a Hetzner cloud account with client configuration (HCLOUD_TOKEN set in env)
* have a Terraform cloud account with client configuration (token set in ~/.terraformrc)
* have a github account
* have terraform and packer (both of hashicorp) installed locally

## Installation

* create server template with packer
* update packer snapshot id in `workspace/assets/system.json`
* run local terraform in workspace directory, which will create a terraform cloud workspace
* complete preparation of Cloud workspace, especially git connection and passwords
* run terraform cloud initially by queuing a run request. Later on, github updates will cause the system to auto-update

# Adding a Wireguard client

* as root, run `/opt/wg/bin/wg_add_client wg0 <planned-dns-name-of-client-without-domain>`
* copy the client information or use the QR code, it will not be kept.