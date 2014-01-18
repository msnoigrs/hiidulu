# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/emacs-jp/migemo.git"

inherit elisp git-2

DESCRIPTION="migemo.el provides Japanese increment search with romaji"
HOMEPAGE="https://github.com/emacs-jp/migemo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
