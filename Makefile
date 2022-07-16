TOP := $(patsubst %/,%,$(dir $(firstword $(MAKEFILE_LIST))))
OAL_BIN := $(shell which oal-cli)
OPENAPI_BIN := $(shell which openapi)
TARGET := $(TOP)/openapi.yaml
BASE := $(TOP)/base.yaml
MAIN := $(TOP)/main.oal

ifeq ($(OAL_BIN),)
$(error oal not found)
endif

ifeq ($(OPENAPI_BIN),)
$(error openapi not found)
endif

.DEFAULT_GOAL := lint

$(TARGET): $(BASE) $(MAIN)
	$(OAL_BIN) -b $(BASE) -i $(MAIN) -o $(TARGET)

.PHONY: build
build: $(TARGET)

.PHONY: lint
lint: $(TARGET)
	$(OPENAPI_BIN) lint $<
