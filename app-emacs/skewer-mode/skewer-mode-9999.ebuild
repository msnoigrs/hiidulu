# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/skeeto/skewer-mode.git"

inherit elisp git-2

DESCRIPTION="Live web developement in Emacs"
HOMEPAGE="https://github.com/skeeto/skewer-mode"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="app-emacs/js2-mode
	app-emacs/simple-httpd"
DEPEND="${COMMON_DEP}"
RDEPEND="${COMMON_DEP}"

SITEFILE="50${PN}-gentoo.el"

src_install() {
	elisp_src_install

	insinto "${SITELISP}/${PN}"
	doins *.js
	doins *.html
}
