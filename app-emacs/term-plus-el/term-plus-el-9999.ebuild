# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/tarao/term-plus-el.git"
#EGIT_HAS_SUBMODULES="yes"

inherit elisp git-2

DESCRIPTION="A terminal emulator in Emacs"
HOMEPAGE="https://github.com/tarao/term-plus-el"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/tab-group-el
	app-emacs/key-intercept-el
	app-emacs/multi-mode
	app-emacs/multi-mode-util
	app-emacs/evil"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	sed -i -e '/multi-mode-util/ d' term+mode.el
	rm term+anything-shell-history.el
}
