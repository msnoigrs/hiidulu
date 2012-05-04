# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/capitaomorte/yasnippet.git"

inherit elisp git-2

DESCRIPTION="Yet another snippet extension for Emacs"
HOMEPAGE="https://github.com/capitaomorte/yasnippet"

# Homepage says MIT licence, source contains GPL-2 copyright notice
LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=app-emacs/dropdown-list-20080316"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	git-2_src_unpack

	# remove bundled copy of dropdown-list
	rm "${S}/dropdown-list.el" || die
}

src_install() {
	elisp_src_install

	insinto "${SITELISP}/${PN}"
	doins -r snippets || die "doins failed"

	if use doc; then
		dohtml -r "${WORKDIR}"/doc/* || die "dohtml failed"
	fi
}

pkg_postinst() {
	elisp-site-regen

#	elog "Please add the following code into your .emacs to use yasnippet:"
#	elog "(require 'yasnippet)"
#	elog "(yas/global-mode 1)"
#	elog "(yas/load-directory \"${SITEETC}/${PN}/snippets\")"
}
