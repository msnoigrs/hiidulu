# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/nonsequitur/git-gutter-plus.git"

inherit elisp git-r3

DESCRIPTION="View, stage and revert Git changes straight from the buffer"
HOMEPAGE="https://github.com/nonsequitur/git-gutter-plus"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/dash
	app-emacs/magit"
RDEPEND="${DEPEND}"

IUSE=""

#SITEFILE="50${PN}-gentoo.el"
