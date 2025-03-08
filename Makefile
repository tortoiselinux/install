PREFIX = /etc/tortoise/tortoise_installer

SCRIPTS = configure.sh install.sh
FILES = env lib.sh welly.conf
DIRS = files logs packages

install:
	@echo "Make dir: $(PREFIX)"
	mkdir -p $(PREFIX)

	@echo "Copying scripts..."
	install -m 755 $(SCRIPTS) $(PREFIX)

	@echo "Copying Files..."
	install -m 644 $(FILES) $(PREFIX)

	@echo "Copying directories..."
	for dir in $(DIRS); do cp -r $$dir $(PREFIX)/; done

	@echo "Installation done!"

uninstall:
	@echo "Removing installation..."
	rm -rf $(PREFIX)
	@echo "Removal completed!"

clean:
	@echo "Nothing to clear."

.PHONY: install uninstall clean
