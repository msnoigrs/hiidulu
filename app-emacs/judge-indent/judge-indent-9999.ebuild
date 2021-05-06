# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/emacsattic/judge-indent.git"

inherit elisp git-r3

DESCRIPTION="Judge indent and tab widths"
HOMEPAGE="http://d.hatena.ne.jp/yascentur/20110626/1309099966"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
