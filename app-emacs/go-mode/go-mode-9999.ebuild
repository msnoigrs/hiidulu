# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/dominikh/go-mode.el.git"

inherit elisp git-r3

DESCRIPTION="Emacs mode for the Go programming language"
HOMEPAGE="https://github.com/dominikh/go-mode.el"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
