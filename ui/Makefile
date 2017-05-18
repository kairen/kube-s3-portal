IMAGE = kairen/s3-portal-ui
VERSION = dev
NAME = s3-ui

.PHONY: all build rm exec

all: build

build:
	docker build -t $(IMAGE):$(VERSION) .
rm:
	docker stop $(NAME) && docker rm $(NAME)
exec:
	docker exec -ti $(NAME) bash
