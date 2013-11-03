DESTDIR =

-include config.mk

all:
	@echo "Usage: ./configure && make install"
	@echo

site_config.lua:
	$(error please run ./configure first)

clean:
	rm -f site_config.lua config.lua.example

install: site_config.lua
	mkdir -p "$(DESTDIR)$(BIN_DIR)"
	install -b -o 0 -g 0 -m 0755 -t "$(DESTDIR)$(BIN_DIR)" \
		bin/taranscript bin/taranrocks 
	install -b -d $(DESTDIR)$(LUA_MODULES_PATH)/luarocks/
	cp -R luarocks/src/luarocks "$(DESTDIR)$(LUA_MODULES_PATH)"
	install -b site_config.lua -m 0644 "$(DESTDIR)$(LUA_MODULES_PATH)/luarocks"
	install -d "$(DESTDIR)$(SYSCONFDIR)"
	install -b config.lua.example -m 0644 "$(DESTDIR)$(SYSCONFDIR)"
	if [ ! -f $(DESTDIR)$(SYSCONFDIR)/config.lua ]; then                   \
		cp $(DESTDIR)$(SYSCONFDIR)/config.lua.example                  \
		   $(DESTDIR)$(SYSCONFDIR)/config.lua;                         \
	fi

deinstall:
	rm -f "$(DESTDIR)$(BIN_DIR)/taranscript"
	rm -f "$(DESTDIR)$(BIN_DIR)/taranrocks"
	rm -rf "$(DESTDIR)$(LUA_MODULES_PATH)/luarocks"
