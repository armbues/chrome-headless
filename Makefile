IMAGE_TAG=armbues/chrome-headless

default: build

build:
	docker build -t ${IMAGE_TAG} .