# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/magit/transient.git"

inherit elisp git-r3

DESCRIPTION="Transient commands"
HOMEPAGE="https://github.com/magit/transient"

DEPEND="app-emacs/compat"
RDEPEND="${DEPEND}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	emake LOAD_PATH="-L ${SITELISP}/dash -L ${SITELISP}/treepy -L ${SITELISP}/compat -L ." lisp info
}

src_install() {
	cd lisp
	elisp_src_install
	cd ..
	doinfo docs/transient.info
}
