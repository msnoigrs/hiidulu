# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/magit/git-modes.git"

inherit elisp git-2

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50git-modes-gentoo.el"

#src_compile() {
#	default
#}

src_install() {
	elisp-install ${PN} git-commit-mode.{el,elc} git-rebase-mode.{el,elc} gitattributes-mode.{el,elc} gitconfig-mode.{el,elc} gitignore-mode.{el,elc}|| die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
