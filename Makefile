build-experimental:
	cat ./cmd/main.go.tpl | sed "s/{dynamic_value}/`date -u +%Y-%m-%dT%H:%M:%S`/g" > ./cmd/main.go

	DOCKER_BUILDKIT=1 time docker build \
		-t gebv/tmp-golang-build-docker:build-experimental \
		-f ./Dockerfile.experimental \
		--target app \
		.

	docker run --rm -it gebv/tmp-golang-build-docker:build-experimental

build:
	cat ./cmd/main.go.tpl | sed "s/{dynamic_value}/`date -u +%Y-%m-%dT%H:%M:%S`/g" > ./cmd/main.go

	time docker build \
		-t gebv/tmp-golang-build-docker:build \
		-f ./Dockerfile \
		--target app \
		.

	docker run --rm -it gebv/tmp-golang-build-docker:build


test: build-experimental build
