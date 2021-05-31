BUILD_DIR=build
BUILDTYPE?=Release

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

.PHONY: all build install clean distclean
