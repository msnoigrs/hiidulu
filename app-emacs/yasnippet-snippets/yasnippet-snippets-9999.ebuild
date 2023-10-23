# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/AndreaCrotti/yasnippet-snippets.git"

inherit elisp git-r3

DESCRIPTION="a collection of yasnippet snippets for many languages"
HOMEPAGE="https://github.com/AndreaCrotti/yasnippet-snippets"

# Homepage says MIT licence, source contains GPL-2 copyright notice
LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-emacs/yasnippet"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	touch .nosearch
}

src_install() {
	insinto "${SITELISP}/${PN}"
	doins .nosearch
	doins -r snippets || die "doins failed"
}
