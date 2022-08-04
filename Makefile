#!/usr/bin/make -f

ABS_PATH_MK := $(abspath $(lastword $(MAKEFILE_LIST)))
ABS_PATH_DIR := $(dir $(ABS_PATH_MK))
NAME := plg_system_ccm19integration
DESTINATION := /var/www/html/joomla/


build: dir
	ln -s $(ABS_PATH_DIR) $(DESTINATION)plugins/system

	ln -s $(ABS_PATH_DIR)media/js	$(DESTINATION)media/$(NAME)/js

dir:
	mkdir -p $(DESTINATION)media/$(NAME)

clear:
	rm -v $(DESTINATION)media/$(NAME)/js

	rm -v $(DESTINATION)plugins/system/ccm19integration

	rm -r $(DESTINATION)media/$(NAME)

