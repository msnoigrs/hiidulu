# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/syohex/emacs-quickrun.git"

inherit elisp git-r3

DESCRIPTION="quickrun.el is Emacs port of quickrun.vim"
HOMEPAGE="https://github.com/syohex/emacs-quickrun"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/ht"
RDEPEND="${DEPEND}"

#SITEFILE="50${PN}-gentoo.el"
