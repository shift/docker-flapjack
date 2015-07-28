all: build push

build:
	docker build -t ${DOCKER_USER}/flapjack:1.6.0 .

push: build
	docker push ${DOCKER_USER}/flapjack:1.6.0

test: build
	docker run -i ${DOCKER_USER}/flapjack:1.6.0 test
