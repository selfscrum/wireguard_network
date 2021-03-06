# wireguard operative interface

- not completed - 

## run-wireguard

Script to initialize a wireguard server that has already installed the software.
This script is typically placed on the vpn server image, and is being started once on machine creation time via the cloud-init script.
It can be used to place additional wg subnets

# client communication functions

These clients mimic an API gateway which this module does not contain. It can be used for manual administration.

## wg_client_request
```
in: 
{
    "wg_id" : "string",
    "client_public_key" : "string"
}
```

```
out:
0 OK
404 ERROR
40401 CLIENT_EXISTS
40402 INVALID_ID
40403 INVALID_PUBLIC_KEY
40405 NO_MORE_SPACE
data:
{
    "proposed_ip" : "string",
    "server_public_key" : "string",
    "endpoint_address" : "string",
    "endpoint_port" : "port",
}
```

## wg_add_client

This call request a complete client configuration from the server's wireguard environment. 
It is expected that the resulting data which can be used at the client are already incorporated into the server's configuration.

```
in: 
{
    "wg_id" : "string",
    "client_dns_name" : "string",
    "client_public_key" : "string" (optional),
    "allowed_ips" : ["string"],
}
```

```
out:
0 OK
404 ERROR
40401 CLIENT_EXISTS
40402 INVALID_ID
40403 INVALID_PUBLIC_KEY
40404 INVALID_IP
```

## wg_del_client
```
in:
{
    "wg_id" : "string",
    "client_public_key" : "string"
}
```

```
out:
0 OK
404 ERROR
40401 CLIENT_DOESNT_EXIST
40402 INVALID_ID
```
