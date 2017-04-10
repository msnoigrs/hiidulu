# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/flycheck/flycheck.git"

inherit elisp git-r3

DESCRIPTION="Modern on the fly syntax checking for GNU Emacs"
HOMEPAGE="http://www.flycheck.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/let-alist
	app-emacs/seq"
RDEPEND="${DEPEND}"

#SITEFILES="50${PN}-gentoo.el"
