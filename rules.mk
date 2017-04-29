# Boilerplate
p := $(p).x
dirstack_$(p) := $(d)
d := $(dir)

# Local rules and targets
ifndef SPARK_VERSION
$(error SPARK_VERSION is undefined)
endif
ifndef HADOOP_VERSION
$(error HADOOP_VERSION is undefined)
endif

DOCKER_IMAGE_$(d) := b9company/spark
DOCKER_TAG_$(d) := $(SPARK_VERSION)-hadoop$(HADOOP_VERSION)-py3

BUILD := $(BUILD) build_$(d)
PUSH := $(PUSH) push_$(d)

build_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
build_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
build_$(d): DOCKER_CONTEXT := $(d)
build_$(d): SPARK_MIRROR := http://apache.crihan.fr/dist/spark
build_$(d): $(d)/Dockerfile
	docker build \
		--build-arg SPARK_VERSION="$(SPARK_VERSION)" \
		--build-arg HADOOP_VERSION="$(HADOOP_VERSION)" \
		--build-arg SPARK_MIRROR="$(SPARK_MIRROR)" \
		$(if $(SPARK_ARCHIVE),--build-arg SPARK_ARCHIVE="$(SPARK_ARCHIVE)") \
		-t "$(DOCKER_IMAGE):$(DOCKER_TAG)" "$(DOCKER_CONTEXT)"

push_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
push_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
push_$(d):
	docker push "$(DOCKER_IMAGE):$(DOCKER_TAG)"

# Boilerplate
d := $(dirstack_$(p))
p := $(basename $(p))
