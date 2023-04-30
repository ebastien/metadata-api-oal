TOP := $(patsubst %/,%,$(dir $(firstword $(MAKEFILE_LIST))))
OAL_BIN := $(shell which oal-cli)
LINT_BIN := $(shell which spectral)
TARGET := $(TOP)/target/openapi.yaml
CONFIG := $(TOP)/oal.toml
SOURCES := $(wildcard $(TOP)/src/*)

ifeq ($(OAL_BIN),)
$(error oal not found)
endif

.DEFAULT_GOAL := build

$(TARGET): $(CONFIG) $(SOURCES)
	$(OAL_BIN) -c $(CONFIG)

.PHONY: build
build: $(TARGET)

.PHONY: lint
lint: $(TARGET)
	$(LINT_BIN) lint $<

.PHONY: clean
clean:
	rm $(TARGET)
