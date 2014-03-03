# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/capitaomorte/yasnippet.git"
EGIT_HAS_SUBMODULES="true"

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

#SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	git-2_src_unpack

	rm -rf "${S}/snippets/.git" || die
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins -r snippets || die "doins failed"

	if use doc; then
		dohtml -r "${WORKDIR}"/doc/* || die "dohtml failed"
	fi
}

#pkg_postinst() {
#	elisp-site-regen
#
#	elog "Please add the following code into your .emacs to use yasnippet:"
#	elog "(require 'yasnippet)"
#	elog "(yas-global-mode 1)"
#}
