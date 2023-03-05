TOP := $(patsubst %/,%,$(dir $(firstword $(MAKEFILE_LIST))))
OAL_BIN := $(shell which oal-cli)
LINT_BIN := $(shell which spectral)
TARGET := $(TOP)/openapi.yaml
BASE := $(TOP)/base.yaml
MAIN := $(TOP)/main.oal

ifeq ($(OAL_BIN),)
$(error oal not found)
endif

.DEFAULT_GOAL := build

$(TARGET): $(BASE) $(MAIN)
	$(OAL_BIN) -b $(BASE) -i $(MAIN) -o $(TARGET)

.PHONY: build
build: $(TARGET)

.PHONY: lint
lint: $(TARGET)
	$(LINT_BIN) lint $<
