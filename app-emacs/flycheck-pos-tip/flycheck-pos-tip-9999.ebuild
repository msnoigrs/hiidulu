# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/flycheck/flycheck-pos-tip.git"

inherit elisp git-r3

DESCRIPTION="Flycheck errors display in tooltip"
HOMEPAGE="https://github.com/flycheck/flycheck-pos-tip"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/pos-tip
	app-emacs/flycheck"
RDEPEND="${DEPEND}"

#SITEFILES="50${PN}-gentoo.el"
