# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/syohex/emacs-quickrun.git"

inherit elisp git-2

DESCRIPTION="quickrun.el is Emacs port of quickrun.vim"
HOMEPAGE="https://github.com/syohex/emacs-quickrun"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
