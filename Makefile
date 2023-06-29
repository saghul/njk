BUILD_DIR=build
BUILDTYPE?=MinSizeRel
JOBS?=$(shell nproc)

all: build

build: build/Makefile
	$(MAKE) -C $(BUILD_DIR) -j$(JOBS)

install:
	@$(MAKE) -C $(BUILD_DIR) install

clean:
	@$(MAKE) -C $(BUILD_DIR) clean

distclean:
	@rm -rf $(BUILD_DIR)

build/Makefile:
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR); cmake ../ -DCMAKE_BUILD_TYPE=$(BUILDTYPE)

build/qjsc: build/Makefile
	$(MAKE) -C $(BUILD_DIR) qjsc -j$(JOBS)

gen: build/qjsc
	$(BUILD_DIR)/qjsc -c -o nunjucks.c -N nunjucks nunjucks.js
	$(BUILD_DIR)/qjsc -c -o main-js.c -N mainjs main.js

.PHONY: all build install clean distclean gen
