# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/dominikh/go-mode.el.git"

inherit elisp git-2

DESCRIPTION="Emacs mode for the Go programming language"
HOMEPAGE="https://github.com/dominikh/go-mode.el"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
