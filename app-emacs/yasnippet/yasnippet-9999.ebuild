# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/joaotavora/yasnippet.git"

inherit elisp git-r3

DESCRIPTION="a template system for Emacs"
HOMEPAGE="http://joaotavora.github.io/yasnippet/"

# Homepage says MIT licence, source contains GPL-2 copyright notice
LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=app-emacs/dropdown-list-20080316"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack

	rm "${S}/yasnippet-debug.el" || die
	rm "${S}/yasnippet-tests.el" || die
}

src_install() {
	elisp_src_install

	if use doc; then
		dohtml -r "${WORKDIR}"/doc/* || die "dohtml failed"
	fi
}
