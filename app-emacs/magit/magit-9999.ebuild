# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/magit/magit.git"

inherit elisp git-r3

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit/"
#SRC_URI="http://github.com/downloads/philjackson/magit/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/async
	app-emacs/dash
	app-emacs/ghub
	app-emacs/transient
	app-emacs/libegit2
	app-emacs/with-editor"
RDEPEND="${RDEPEND}"

SITEFILE="50magit-gentoo.el"

src_compile() {
	emake \
		PREFIX="/usr" \
		DASH_DIR="${SITELISP}/dash" \
		GHUB_DIR="${SITELISP}/ghub" \
		TRANSIENT_DIR="${SITELISP}/transient" \
		LIBGIT_DIR="${SITELISP}/libegit2" \
		WITH_EDITOR_DIR="${SITELISP}/with-editor" lisp info
}

src_install() {
	doinfo Documentation/magit.info
	cd lisp
	emake PREFIX="${D}/usr" install
}
