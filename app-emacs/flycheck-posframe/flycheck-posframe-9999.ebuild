# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/alexmurray/flycheck-posframe.git"

inherit elisp git-r3

DESCRIPTION="Show flycheck errors via postframe.el"
HOMEPAGE="https://github.com/alexmurray/flycheck-posframe"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/posframe
	app-emacs/flycheck"
RDEPEND="${DEPEND}"
