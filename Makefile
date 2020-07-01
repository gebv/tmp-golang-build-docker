build-experimental:
	cat ./cmd/main.go.tpl | sed "s/{dynamic_value}/`date -u +%Y-%m-%dT%H:%M:%S`/g" > ./cmd/main.go

	DOCKER_BUILDKIT=1 time docker build \
		--progress plain \
		-t gebv/tmp-golang-build-docker:build-experimental \
		-f ./Dockerfile.experimental \
		--target app \
		.

	docker run --rm -it gebv/tmp-golang-build-docker:build-experimental

build:
	cat ./cmd/main.go.tpl | sed "s/{dynamic_value}/`date -u +%Y-%m-%dT%H:%M:%S`/g" > ./cmd/main.go

	time docker build \
		--progress plain \
		-t gebv/tmp-golang-build-docker:build \
		-f ./Dockerfile \
		--target app \
		.

	docker run --rm -it gebv/tmp-golang-build-docker:build


build-manual-cache:
	cat ./cmd/main.go.tpl | sed "s/{dynamic_value}/`date -u +%Y-%m-%dT%H:%M:%S`/g" > ./cmd/main.go

	time docker build \
		--progress plain \
		-t gebv/tmp-golang-build-docker:build-manual-cache \
		-f ./Dockerfile.manualcache \
		--target app \
		.

	docker run --rm -it gebv/tmp-golang-build-docker:build-manual-cache

build-manual-cache2:
	cat ./cmd/main.go.tpl | sed "s/{dynamic_value}/`date -u +%Y-%m-%dT%H:%M:%S`/g" > ./cmd/main.go

	time docker build \
		--progress plain \
		-t gebv/tmp-golang-build-docker:build-manual-cache2 \
		-f ./Dockerfile.manualcache2 \
		--target app \
		.

	docker run --rm -it gebv/tmp-golang-build-docker:build-manual-cache2

test: build-experimental build build-manual-cache build-manual-cache2

demo:
	make test 2>&1 | grep -C 2 real
