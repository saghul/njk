BUILD_DIR=build
BUILDTYPE?=MinSizeRel

all: build

build:
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR); cmake ../ -DCMAKE_BUILD_TYPE=$(BUILDTYPE)
	$(MAKE) -C $(BUILD_DIR) -j4

install:
	@$(MAKE) -C $(BUILD_DIR) install

clean:
	@$(MAKE) -C $(BUILD_DIR) clean

distclean:
	@rm -rf $(BUILD_DIR)

gen:
	$(MAKE) -C quickjs qjsc -j4
	./quickjs/qjsc -c -o nunjucks.c -N nunjucks nunjucks.js
	./quickjs/qjsc -c -o main-js.c -N mainjs main.js

.PHONY: all build install clean distclean gen
