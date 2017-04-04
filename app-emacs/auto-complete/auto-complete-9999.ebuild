# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/auto-complete/auto-complete.git"

inherit elisp eutils git-r3

DESCRIPTION="Auto-complete package"
HOMEPAGE="http://cx4a.org/software/auto-complete/
	http://github.com/auto-complete/auto-complete/"
#SRC_URI="http://cx4a.org/pub/${PN}/${P}.tar.bz2"
SRC_URI=""

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_ja"

COMMON_DEP="app-emacs/popup-el"
DEPEND="${DEPEND} ${COMMON_DEP}"
RDEPEND="${RDEPEND} ${COMMON_DEP}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}"/border-width.patch
}

src_install() {
	elisp_src_install

	# install dictionaries
	insinto "${SITEETC}/${PN}"
	doins -r dict || die

	#dodoc etc/test.txt || die
	#cd doc
	#dodoc index.txt manual.txt demo.txt changes.txt *.png || die
	#if use linguas_ja; then
	#	dodoc index.ja.txt manual.ja.txt changes.ja.txt || die
	#fi
}
