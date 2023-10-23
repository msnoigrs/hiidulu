# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/magit/git-modes.git"

inherit elisp git-r3

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/compat"
RDEPEND="${DEPEND}"

#SITEFILE="50git-modes-gentoo.el"

src_compile() {
	emake LOAD_PATH="-L ${SITELISP}/compat -L ." lisp
}

src_install() {
	elisp-install ${PN} gitattributes-mode.{el,elc} gitconfig-mode.{el,elc} gitignore-mode.{el,elc} git-modes-autoloads.el|| die
	#elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
