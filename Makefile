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
	rm -f $(DESTINATION)media/$(NAME)/js

	rm -f $(DESTINATION)plugins/system/ccm19integration

	rm -fr $(DESTINATION)media/$(NAME)

	rm -fr $(CURDIR)/build/

ccm19integration.zip:
	mkdir -p "build"

	rsync -a --exclude='build' --exclude='.*' $(CURDIR)/ $(CURDIR)/build/ccm19integration/

	cd  $(CURDIR)/build/ && zip -FSr ccm19integration.zip ccm19integration

