SHELL:=/bin/bash

CILIUM_CLI=cilium
CILIUM_VERSION=1.14.2

KIND_CONFIG=kind-config.yaml


kind-config.yaml:
	curl -LO https://raw.githubusercontent.com/cilium/cilium/$(CILIUM_VERSION)/Documentation/installation/$@

.PHONY: cluster
cluster: $(KIND_CONFIG)
	kind create cluster --config=$(KIND_CONFIG)

.PHONY: install
install:
	$(CILIUM_CLI) install --version $(CILIUM_VERSION) --wait

.PHONY: install-cli
install-cli:
	brew install cilium-cli

.PHONY: check
check:
	$(CILIUM_CLI) connectivity test

.PHONY: setup
setup: cluster install-cli install check