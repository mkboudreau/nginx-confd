# Docker image files for nginx and confd

## Summary
This docker image allows a quick reverse proxy set up in nginx. It has confd embedded to allow passing in a couple parameters either as an env var or from a config server such as etcd, consul, zookeeper, etc.

## Basic Usage
Besides the typical docker options, such as -d for daemon mode and -p for port mapping, the env vars this docker image accepts are as follows:
- `NGINX_HOST`: This sets the server name of the nginx config
- `UPSTREAM_<name>`: There can be several env vars that are prefixed with `UPSTREAM_`. There must be some unique name after each UPSTREAM_ prefix.
- `NGINX_TLS_KEY`: This sets the path to the key file in the docker container. Preferably, this is volume mounted into the container.
- `NGINX_TLS_CERTIFICATE`: This sets the path to the certificate file in the docker container. Preferably, this is volume mounted into the container.
- `NGINX_TLS_ONLY`: This will make sure there is no listener on port 80.

If none of the NGINX_TLS_* options are set, then the nginx server will not attempt to listen on port 443. 

## Example

**Basic Command with no TLS**

```bash
docker run -d 
    -e NGINX_HOST=www.myhost.com 
    -e UPSTREAM_APP1=192.168.0.1:8080 
    -e UPSTREAM_APP2=192.168.0.2:8080 
    -p 80:80 
    mkboudreau/nginx-confd
```

**Explanation of Command**

1. The command is running in daemon mode `-d`.
2. The command is telling nginx that its server name is www.myhost.com with the env var `NGINX_HOST`
3. The command is setting nginx to reverse proxy to two hosts: 192.168.0.1:8080 and 192.168.0.2:8080
4. The command is setting nginx to listen on port 80 by mapping the internal docker container port 80 to external 80

## More Examples

**Basic Command with TLS**

```bash
docker run -d 
    -e NGINX_HOST=www.myhost.com 
    -e UPSTREAM_APP1=192.168.0.1:8080 
    -e UPSTREAM_APP2=192.168.0.2:8080 
    -e NGINX_TLS_KEY=/<path>/tls.key 
    -e NGINX_TLS_CERTIFICATE=/<path/tls.crt 
    -p 80:80 
    -p 443:443
    mkboudreau/nginx-confd
```

**Basic Command with TLS ONLY**

```bash
docker run -d 
    -e NGINX_HOST=www.myhost.com 
    -e UPSTREAM_APP1=192.168.0.1:8080 
    -e UPSTREAM_APP2=192.168.0.2:8080 
    -e NGINX_TLS_KEY=/<path>/tls.key 
    -e NGINX_TLS_CERTIFICATE=/<path/tls.crt 
    -e NGINX_TLS_ONLY=true
    -p 443:443
    mkboudreau/nginx-confd
```
