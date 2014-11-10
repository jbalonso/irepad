IMAGE=j.hack:5000/ui-base

.PHONY: build pull push

all: build

pull:
	docker pull ${IMAGE}

build:
	docker run -i --rm -v "${CURDIR}:/data" ${IMAGE} /data/.build.sh

push:
	@echo dist.tar.gz NEEDS TO BE COPIED SOMEWHERE
