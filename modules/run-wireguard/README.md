# wireguard operative interface

## run-wireguard

Script to initialize a wireguard server that has already the software installed.
This script is typically placed on the vpn server image, and is being started once on machine creation time via the cloud-init script.


# client communication functions

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
```
in: 
{
    "wg_id" : "string",
    "client_public_key" : "string"
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
