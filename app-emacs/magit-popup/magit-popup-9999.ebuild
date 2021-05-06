# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/magit/magit-popup.git"

inherit elisp git-r3

DESCRIPTION="Define prefix-Infix-suffix command combos"
HOMEPAGE="https://github.com/magit/magit-popup"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/dash"
RDEPEND="${RDEPEND}"

src_compile() {
	emake LOAD_PATH="-L ${SITELISP}/dash  -L ." lisp info
}

src_install() {
	elisp_src_install
	doinfo magit-popup.info
}
