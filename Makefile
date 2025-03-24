VERSION = 2.48
PN = modprobed-db

PREFIX = /data/data/com.termux/files/usr
BINDIR = $(PREFIX)/bin
DOCDIR = $(PREFIX)/share/doc/$(PN)-$(VERSION)
MANDIR = $(PREFIX)/share/man/man8
SKELDIR = $(PREFIX)/share/$(PN)
BASHDIR = $(PREFIX)/share/bash-completion/completions
ZSHDIR = $(PREFIX)/share/zsh/site-functions

INSTALL = install -p
INSTALL_PROGRAM = $(INSTALL) -m755
INSTALL_DATA = $(INSTALL) -m644
INSTALL_DIR = $(INSTALL) -d

RM = rm
Q = @

all:
	$(Q)echo -e '\033[1;32mSetting version\033[0m'
	$(Q)sed 's/@VERSION@/'$(VERSION)'/' common/$(PN).in > common/$(PN)

install-bin:
	$(Q)echo -e '\033[1;32mInstalling main script and skel config...\033[0m'
	$(INSTALL_DIR) "$(BINDIR)"
	$(INSTALL_DIR) "$(SKELDIR)"
	$(INSTALL_PROGRAM) common/$(PN) "$(BINDIR)/$(PN)"
	$(INSTALL_DATA) common/$(PN).skel "$(SKELDIR)/$(PN).skel"

	$(INSTALL_DIR) "$(BASHDIR)"
	$(INSTALL_DATA) common/bash-completion "$(BASHDIR)/modprobed-db"
	$(INSTALL_DIR) "$(ZSHDIR)"
	$(INSTALL_DATA) common/zsh-completion "$(ZSHDIR)/_modprobed-db"

install-man:
	$(Q)echo -e '\033[1;32mInstalling manpage...\033[0m'
	$(INSTALL_DIR) "$(DESTDIR)$(MANDIR)"
	$(INSTALL_DATA) doc/$(PN).8 "$(DESTDIR)$(MANDIR)/$(PN).8"

install: install-bin install-man

uninstall:
	$(Q)$(RM) "$(DESTDIR)$(BINDIR)/$(PN)" "$(DESTDIR)$(MANDIR)/$(PN).8"
	$(Q)$(RM) -rf "$(DESTDIR)$(SKELDIR)"
	$(Q)$(RM) "$(DESTDIR)/$(ZSHDIR)/_modprobed-db" "$(DESTDIR)$(BASHDIR)/modprobed-db"
