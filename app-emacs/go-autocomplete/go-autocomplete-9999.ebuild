# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/nsf/gocode.git"

inherit elisp git-2

DESCRIPTION="auto-complete-mode backend for go-mode"
HOMEPAGE="https://github.com/nsf/gocode"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/auto-complete"
RDEPEND="${DEPEND}
	dev-go/gocode"

#SITEFILES="50${PN}-gentoo.el"

src_compile() {
	cd emacs
	elisp_src_compile
}

src_install() {
	cd emacs
	elisp_src_install
}
