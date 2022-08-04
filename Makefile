#!/usr/bin/make -f

makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
abs_path_dir := $(dir $(makefile_path))
NAME := plg_system_ccm19integration
DESTINATION := /var/www/html/joomla/

#Links the folders to the Joomla counterpart for discover installation.
build: installdirs $(abs_path_dir)
	ln -s $(abs_path_dir) $(DESTINATION)plugins/system

	ln -s $(abs_path_dir)media/js	$(DESTINATION)media/$(NAME)/js

installdirs:
	mkdir -p $(DESTINATION)media/$(NAME)

clean:
	rm -v $(DESTINATION)media/$(NAME)/js

	rm -v $(DESTINATION)plugins/system/ccm19integration

	rm -r $(DESTINATION)media/$(NAME)

