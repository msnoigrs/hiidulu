# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/magit/git-modes.git"

inherit elisp git-r3

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50git-modes-gentoo.el"

src_compile() {
	emake
}

src_install() {
	elisp-install ${PN} gitattributes-mode.{el,elc} gitconfig-mode.{el,elc} gitignore-mode.{el,elc}|| die
	#elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
