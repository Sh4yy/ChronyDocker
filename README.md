# ChronyDocker
> Docker Image for Chrony

### Installation
- To run an NTP/NTS client or server, configure the chrony.conf file based on [Chrony's documentations](https://chrony.tuxfamily.org/documentation.html).
- The Dockerfile requires a `server.key` and a `server.crt` in the `PEM` format which can be build using `gen_certs.sh`
- Run `make build` to build the Docker image and `make run` to execute the image.
