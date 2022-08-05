#!/usr/bin/make -f

NAME := plg_system_ccm19integration
DESTINATION := /var/www/html/joomla/

#Links the folders to the Joomla counterpart for discover installation.
build: installdirs $(DESTINATION)
	ln -s $(CURDIR) $(DESTINATION)plugins/system

	ln -s $(CURDIR)/media/js	$(DESTINATION)media/$(NAME)/js

installdirs:
	mkdir -p $(DESTINATION)media/$(NAME)

clean:
	rm -v $(DESTINATION)media/$(NAME)/js

	rm -v $(DESTINATION)plugins/system/ccm19integration

	rm -r $(DESTINATION)media/$(NAME)

ccm19integration.zip:
	mkdir -p "build"

	rsync -r $(CURDIR)/ $(CURDIR)/build/ccm19integration/

	cd $(CURDIR)/build/ && zip -FSr ccm19integration.zip ccm19integration
