# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/magit/with-editor.git"

inherit elisp git-r3

DESCRIPTION="Use the Emacsclient as the $EDITOR of child processes"
HOMEPAGE="https://github.com/magit/with-editor"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/dash"

src_compile() {
	emake LOAD_PATH="-L ${SITELISP}/dash  -L ." lisp info
}

src_install() {
	doinfo docs/with-editor.info
	cd lisp
	elisp_src_install
}
