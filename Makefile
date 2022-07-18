# Makefile for creating kafka-zookeeper Docker image
#

# 1st item is default, so 'make' with no arguments shows help
## help: show this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /' | sort


# define docker to run using BUILDKIT features
DOCKER = DOCKER_BUILDKIT=1 docker

# Platforms defaults to amd64 and arm64, but one can override at runtime (e.g., PLATFORMS=linux/amd64 make xxx)
PLATFORMS ?= linux/amd64,linux/arm64

# Set buildx builder
BUILDER ?= builder-local

# Kafka Version
KAFKA_VERSION ?= 2.6.0

# TAG
TAG = dougdonohoe/kafka-zookeeper:$(KAFKA_VERSION)

# common setup for buildx tasks
buildx-setup:
	$(DOCKER) buildx ls
	@if ! $(DOCKER) buildx inspect --builder $(BUILDER) > /dev/null 2>&1; then \
  		echo "Creating new builder '$(BUILDER)'"; \
  		$(DOCKER) buildx create --name $(BUILDER); \
	else \
		echo "Using existing builder $(BUILDER)"; \
	fi

## buildx-publish: build and publish the multi-architecture image (amd64|arm64)
buildx-publish:
	@echo '=> Build and publish multi-arch image $(TAG)...'
	$(DOCKER) buildx build --file Dockerfile \
		--platform $(PLATFORMS) \
		--builder $(BUILDER) \
		--build-arg KAFKA_VERSION=$(KAFKA_VERSION) \
		--progress plain \
		--pull --push --tag $(TAG) .
