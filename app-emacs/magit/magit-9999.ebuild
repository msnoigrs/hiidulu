# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/magit/magit.git"

inherit elisp git-r3

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit/"
#SRC_URI="http://github.com/downloads/philjackson/magit/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/dash
	app-emacs/ghub
	app-emacs/magit-popup
	app-emacs/with-editor"
RDEPEND="${RDEPEND}"

SITEFILE="50magit-gentoo.el"

src_compile() {
	emake \
		DASH_DIR="${SITELISP}/dash" \
		GHUB_DIR="${SITELISP}/ghub" \
		MAGIT_POPUP_DIR="${SITELISP}/magit-popup" \
		WITH_EDITOR_DIR="${SITELISP}/with-editor" lisp info
}

src_install() {
	doinfo Documentation/magit.info
	cd lisp
	default
}
