# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/ScottyB/ac-js2.git"

inherit elisp git-2

DESCRIPTION="Javascript auto-completion in Emacs using Js2-mode's parser"
HOMEPAGE="https://github.com/ScottyB/ac-js2"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/js2-mode
	app-emacs/skewer-mode"
RDEPEND="${DEPEND}"

#SITEFILES="50${PN}-gentoo.el"

src_prepare() {
	rm ac-js2-test.el
	sed -i -e "/etags/ a (require 'auto-complete)" ac-js2.el
}

src_install() {
	elisp_src_install

	insinto "${SITELISP}/${PN}"
	doins skewer-addon.js || die
}
