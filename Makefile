ROOTFS=../profile/airootfs

SCRIPTS = configure.sh install.sh
LIB = lib.sh
CONFIGS = egginstall.conf welly.conf
STATICFILES = files 
PACKAGECONFIGDIR= packages

SCRIPTDIR= /usr/local/bin
LIBDIR= /usr/lib/tortoise
CONFIGDIR= /etc/tortoise
STATICDIR= /usr/share/tortoise

prepare:
	@echo "Verificando e limpando arquivos antigos..."
	@[ -e $(ROOTFS)/$(SCRIPTDIR)/egginstall ] && rm -f $(ROOTFS)/$(SCRIPTDIR)/egginstall || true
	@[ -e $(ROOTFS)/$(SCRIPTDIR)/configure ] && rm -f $(ROOTFS)/$(SCRIPTDIR)/configure || true
	@[ -e $(ROOTFS)/$(LIBDIR)/lib.sh ] && rm -f $(ROOTFS)/$(LIBDIR)/lib.sh || true
	@[ -d $(ROOTFS)/$(CONFIGDIR)/$(PACKAGECONFIGDIR) ] && rm -rf $(ROOTFS)/$(CONFIGDIR)/$(PACKAGECONFIGDIR) || true
	@[ -d $(ROOTFS)/$(STATICDIR)/$(STATICFILES) ] && rm -rf $(ROOTFS)/$(STATICDIR)/$(STATICFILES) || true

	@echo "Make directories..."
	mkdir -p $(ROOTFS)/$(SCRIPTDIR) $(ROOTFS)/$(LIBDIR) $(ROOTFS)/$(CONFIGDIR) $(ROOTFS)/$(STATICDIR)

	@echo "Copying scripts..."
	install -m 755 -C $(SCRIPTS) $(ROOTFS)/$(SCRIPTDIR)
	install -m 755 -C $(ROOTFS)/$(SCRIPTDIR)/install.sh $(ROOTFS)/$(SCRIPTDIR)/egginstall
	install -m 755 -C $(ROOTFS)/$(SCRIPTDIR)/configure.sh $(ROOTFS)/$(SCRIPTDIR)/configure
	rm -f $(ROOTFS)/$(SCRIPTDIR)/install.sh $(ROOTFS)/$(SCRIPTDIR)/configure.sh

	@echo "Copying config Files..."
	install -m 644 -C $(CONFIGS) $(ROOTFS)/$(CONFIGDIR)
	install -d $(ROOTFS)/$(CONFIGDIR)/$(PACKAGECONFIGDIR)
	cp -r $(PACKAGECONFIGDIR)/* $(ROOTFS)/$(CONFIGDIR)/$(PACKAGECONFIGDIR)/ 2>/dev/null || true

	@echo "Copying lib Files..."
	install -m 644 -C $(LIB) $(ROOTFS)/$(LIBDIR)

	@echo "Copying directories..."
	install -d $(ROOTFS)/$(STATICDIR)
	cp -r $(STATICFILES) $(ROOTFS)/$(STATICDIR)/
	@echo "Installation done!"

install:
	@echo "Verificando e limpando arquivos antigos..."
	@[ -e $(SCRIPTDIR)/egginstall ] && rm -f $(SCRIPTDIR)/egginstall || true
	@[ -e $(SCRIPTDIR)/configure ] && rm -f $(SCRIPTDIR)/configure || true
	@[ -e $(LIBDIR)/lib.sh ] && rm -f $(LIBDIR)/lib.sh || true
	@[ -d $(CONFIGDIR)/$(PACKAGECONFIGDIR) ] && rm -rf $(CONFIGDIR)/$(PACKAGECONFIGDIR) || true
	@[ -d $(STATICDIR)/$(STATICFILES) ] && rm -rf $(STATICDIR)/$(STATICFILES) || true

	@echo "Make directories..."
	mkdir -p $(SCRIPTDIR) $(LIBDIR) $(CONFIGDIR) $(STATICDIR)

	@echo "Copying scripts..."
	install -m 755 -C $(SCRIPTS) $(SCRIPTDIR)
	mv $(SCRIPTDIR)/install.sh  $(SCRIPTDIR)/egginstall
	mv $(SCRIPTDIR)/configure.sh  $(SCRIPTDIR)/configure

	@echo "Copying config Files..."
	install -m 644 -C $(CONFIGS) $(CONFIGDIR)
	install -d $(CONFIGDIR)/$(PACKAGECONFIGDIR)
	cp -r $(PACKAGECONFIGDIR)/* $(CONFIGDIR)/$(PACKAGECONFIGDIR)/ 2>/dev/null || true

	@echo "Copying lib Files..."
	install -m 644 -C $(LIB) $(LIBDIR)

	@echo "Copying directories..."
	install -d $(STATICDIR)
	cp -r $(STATICFILES) $(STATICDIR)/

	@echo "Installation done!"

uninstall:
	@echo "Removing installation..."
	rm -f $(SCRIPTDIR)/egginstall $(SCRIPTDIR)/configure
	rm -f $(LIBDIR)/lib.sh
	rm -f $(CONFIGDIR)/egginstall.conf $(CONFIGDIR)/welly.conf
	rm -rf $(CONFIGDIR)/$(PACKAGECONFIGDIR)
	rm -rf $(STATICDIR)/$(STATICFILES)
	@echo "Removal completed!"

clean:
	@echo "Nothing to clear."

.PHONY: prepare install uninstall clean
