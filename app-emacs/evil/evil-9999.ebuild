# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/evil/evil.git"

inherit elisp git-2

DESCRIPTION="An extensible vi layer for Emacs"
HOMEPAGE="http://gitorious.org/evil"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/goto-chg
	app-emacs/undo-tree"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	rm evil-pkg.el lib/undo-tree.el lib/goto-chg.el || die
}

pkg_postinst() {
	elisp-site-regen
}
