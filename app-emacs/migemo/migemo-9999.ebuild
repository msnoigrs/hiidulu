# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/emacs-jp/migemo.git"

inherit elisp git-r3

DESCRIPTION="migemo.el provides Japanese increment search with romaji"
HOMEPAGE="https://github.com/emacs-jp/migemo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/cmigemo"

#SITEFILE="50${PN}-gentoo.el"
