# Docker image files for nginx and confd

## Summary
This docker image allows a quick reverse proxy set up in nginx. It has confd embedded to allow passing in a couple parameters either as an env var or from a config server such as etcd, consul, zookeeper, etc.

## Limitations
Currently the set up is for http only, no https. In addition, the config options that can be easily setup are only for the server name and the reverse proxied host:port. 

Of course, advanced docker users, could easily swap out any of the files using `-v`.

## Basic Usage
Besides the typical docker options, such as -d for daemon mode and -p for port mapping, the env vars this docker image accepts are as follows:
- **NGINX_HOST**: This sets the server name of the nginx config
- **UPSTREAM_<name>**: There can be several env vars that are prefixed with *UPSTREAM_*. There must be some unique name after each UPSTREAM_ prefix.

## Example

**Command**
```bash
docker run -d -e NGINX_HOST=www.myhost.com -e UPSTREAM_APP1=192.168.0.1:8080 -e UPSTREAM_APP2=192.168.0.2:8080 -p 80:80 mkboudreau/nginx-confd
```

**Explanation of Command**

1. The command is running in daemon mode `-d`.
2. The command is telling nginx that its server name is www.myhost.com with the env var `NGINX_HOST`
3. The command is setting nginx to reverse proxy to two hosts: 192.168.0.1:8080 and 192.168.0.2:8080
4. The command is setting nginx to listen on port 80 by mapping the internal docker container port 80 to external 80

