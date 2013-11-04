# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/magit/magit.git"

inherit elisp git-2

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://philjackson.github.com/magit/"
#SRC_URI="http://github.com/downloads/philjackson/magit/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/git-modes"
RDEPEND="${RDEPEND}"

SITEFILE="50magit-gentoo.el"

src_compile() {
	elisp_src_compile
	emake docs
}

src_install() {
	elisp-install ${PN} magit{,-bisect,-blame,-key-mode,-stgit,-svn,-topgit,-wip}.{el,elc} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo magit.info
	dodoc README.md
}
