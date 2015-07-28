# Flapjack

Docker image inheritance:
 * shift/ubuntu:15.04
 * ubuntu:15.04

## Volumes

 * /etc/flapjack

## Ports

Exposed ports:
 * 3080/tcp
 * 3081/tcp

## Example usage

```
docker run -d --name redis redis
docker run -d --name flapjack --link redis:redis -p 3080:3080 -p 3081:3081 shift/flapjack:1.6.0 server
```

The containers takes the following:

 * server - Starts the flapjack server
 * test - Used to output the flapjack version (flapjack --version)
 * shell - Gives a Bash shell.
