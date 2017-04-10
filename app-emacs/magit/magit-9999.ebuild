# Copyright 1999-2017 Gentoo Foundation
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

DEPEND="app-emacs/dash"
RDEPEND="${RDEPEND}"

SITEFILE="50magit-gentoo.el"

src_compile() {
	#elisp_src_compile
	#emake docs
	emake DASH_DIR=${SITELISP}/dash
}

src_install() {
	cd lisp
	elisp-install ${PN} magit{,-apply,-bisect,-blame,-commit,-core,-diff,-ediff,-extras,-git,-log,-mode,-popup,-process,-remote,-section,-sequence,-stash,-utils,-wip}.{el,elc} || die
	elisp-install ${PN} git{-commit,-rebase}.{el,elc} || die
	elisp-install ${PN} with-editor.{el,elc} || die
	elisp-install ${PN} magit-version.el magit-autoloads.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	cd ..
	doinfo Documentation/magit.info
	dodoc README.md
}
