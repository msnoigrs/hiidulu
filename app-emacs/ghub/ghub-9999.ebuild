# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/magit/ghub.git"

inherit elisp git-r3

DESCRIPTION="Minuscule client library for the Github API"
HOMEPAGE="https://github.com/magit/ghub"

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
	doinfo ghub.info
}
