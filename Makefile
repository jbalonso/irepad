IMAGE=j.lab.int.hackorp.com:5000/ui-base:latest

.PHONY: build pull push

all: build

pull:
	docker pull ${IMAGE}

build:
	docker run -i -t --rm -u $$(id -u) -v "${CURDIR}:/src" ${IMAGE} ./build.sh

push:
	@echo dist.tar.gz NEEDS TO BE COPIED SOMEWHERE
