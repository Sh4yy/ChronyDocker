all: build run

build:
	docker build -t chrony --pull .
run:
	docker run --rm --name chrony -p 123:123/udp -p 11443:443 -p 4460:4460 chrony
