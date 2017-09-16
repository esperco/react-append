# Get package subdirectories
export PKGDIRS := $(wildcard packages/*)

# Make targets for package directories
export PKGCMDS := clean build test

# Phone so pkg dir targets actually do something
.PHONY: default setup publish $(PKGDIRS) $(PKGCMDS) 

# Put Node bins in path
export PATH := node_modules/.bin:$(PATH)
export SHELL := /bin/bash

default: build

publish:
	$(MAKE) build
	lerna publish

setup:
	yarn install
	lerna bootstrap

lint:
	tslint --type-check --project tsconfig.build.json

$(PKGCMDS): $(PKGDIRS)
$(PKGDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)