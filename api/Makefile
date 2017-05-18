IMAGE = kairen/s3-portal-api
VERSION = dev
NAME = s3-api

.PHONY: all build rm exec

all: build

build:
	docker build -t $(IMAGE):$(VERSION) .
rm:
	docker stop $(NAME) && docker rm $(NAME)
exec:
	docker exec -ti $(NAME) bash
