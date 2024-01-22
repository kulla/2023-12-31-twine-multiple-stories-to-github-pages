.PHONY: build help install run

MANIFEST=$(NAME).yml
BUILD_DIR=build-dir
PWD=$(shell pwd)

default: help

build:
	flatpak-builder --force-clean $(BUILD_DIR) $(MANIFEST)

clean:
	rm -rfv .flatpak-builder

help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "build   – Build tweego"
	@echo "clean   – Clean build cache"
	@echo "install – Install tweego"
	@echo "run     – Run tweego with story.twee"

install:
	flatpak-builder --user --install --force-clean $(BUILD_DIR) $(MANIFEST)

public:
	mkdir -p public

run: story.twee public
	scripts/run_tweego.sh -o public/index.html $<
