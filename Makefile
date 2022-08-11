#!/usr/bin/make -f

NAME := plg_system_ccm19integration

#Creats install ready package in the build folder
build:
	mkdir -p "build"

	rsync -a --exclude='build' --exclude='.*' $(CURDIR)/ $(CURDIR)/build/ccm19integration/

	cd  $(CURDIR)/build/ && zip -FSr ccm19integration.zip ccm19integration

clean:
	rm -fr $(CURDIR)/build/



