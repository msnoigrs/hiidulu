# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/tarao/multi-mode-util.git"

inherit elisp git-2

DESCRIPTION="A package of Emacs Lisp for easy-to-use multiple major mode."
HOMEPAGE="https://github.com/tarao/multi-mode-util#readme"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

DEPEND="app-emacs/evil
	app-emacs/multi-mode"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elisp-site-regen
}
