.PHONY: test

test:
	docker build -f Dockerfile.test --build-arg BASE_IMAGE=ubuntu:24.04 --build-arg PACKAGE_MANAGER=apt -t puppet-codedeploy:ubuntu-24.04 .
	docker build -f Dockerfile.test --build-arg BASE_IMAGE=ubuntu:26.04 --build-arg PACKAGE_MANAGER=apt -t puppet-codedeploy:ubuntu-26.04 .
	docker build -f Dockerfile.test --build-arg BASE_IMAGE=amazonlinux:2023 --build-arg PACKAGE_MANAGER=yum -t puppet-codedeploy:al2023 .
