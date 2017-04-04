# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/tkf/emacs-jedi.git"

inherit elisp git-r3

DESCRIPTION="Python auto-completion for Emacs"
HOMEPAGE="http://tkf.github.io/emacs-jedi/latest/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/emacs-epc
	app-emacs/emacs-deferred
	app-emacs/emacs-python-environment
	app-emacs/auto-complete"
RDEPEND="${DEPEND}
	dev-python/jedi
	dev-python/python-epc
	dev-python/sexpdata"

#SITEFILES="50${PN}-gentoo.el"

src_prepare() {
	rm test-*.el
}

src_install() {
	elisp_src_install

	insinto "${SITELISP}/${PN}"
	doins jediepcserver.py || die
}
