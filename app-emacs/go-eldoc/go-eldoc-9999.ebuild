# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/syohex/emacs-go-eldoc.git"

inherit elisp git-r3

DESCRIPTION="eldoc for go language"
HOMEPAGE="https://github.com/syohex/emacs-go-eldoc"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/go-mode"
RDEPEND="${DEPEND}
	dev-go/gocode"

#SITEFILES="50${PN}-gentoo.el"
