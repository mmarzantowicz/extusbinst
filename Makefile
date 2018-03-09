VERSION = $(shell git describe | sed 's/-/+/g;s/^v//;')

SCRIPTS = update-kernel

ALPM_HOOK = alpm-hook.in

CONFIG = extusbinst.conf

LIBRARY = \
	  color.sh \
	  messages.sh

HOOKS ?= linux.hook

space :=
space +=
HOOK_LIST := $(subst $(space),\|,$(patsubst %.hook,%,$(wildcard *.hook)))

srcdir = .

all: $(SCRIPTS) $(HOOKS)


$(HOOKS): edit = sed 's|@pkg@|$*|g'
$(HOOKS): %.hook: $(ALPM_HOOK) Makefile
	$(RM) $@
	cat $(ALPM_HOOK) | $(edit) > $@


$(SCRIPTS): assemble = m4 -P $(srcdir)/$@.sh.in
$(SCRIPTS): edit = sed 's|VERSION=.*|VERSION=$(VERSION)|g'
$(SCRIPTS): %: %.sh.in $(LIBRARY) Makefile
	$(RM) $@
	$(assemble) | $(edit) > $@

clean:
	@echo "Cleaning git repository..."
	$(RM) *.hook
	$(RM) $(SCRIPTS)

install:
	@echo "Installing files..."
	test -d $(DESTDIR)/etc/pacman.d/hooks \
	    || install -d $(DESTDIR)/etc/pacman.d/hooks
	
	for hook in $(srcdir)/*.hook; do \
	    sed -e 's|@destdir@|$(DESTDIR)|g' \
	    	$$hook > $(DESTDIR)/etc/pacman.d/hooks/$$hook ; \
	done

	test -d $(DESTDIR)/etc/pacman.d/scripts \
	    || install -d $(DESTDIR)/etc/pacman.d/scripts

	sed -e 's|CONFIG=.*|CONFIG=$(DESTDIR)/etc/conf.d/extusbinst|' \
	    -e 's|KERNEL_PACKAGE=.*|KERNEL_PACKAGE="$(HOOK_LIST)"|' \
	    $(srcdir)/update-kernel > $(DESTDIR)/etc/pacman.d/scripts/update-kernel
	
	test -f $(DESTDIR)/etc/conf.d/extusbinst \
	    || install -D -m644 $(CONFIG) $(DESTDIR)/etc/conf.d/extusbinst


version:
	@echo $(VERSION)

.PHONY: all clean install version
