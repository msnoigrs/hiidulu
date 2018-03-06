# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/emacsmirror/visual-basic-mode.git"

inherit elisp git-r3

DESCRIPTION="A mode for editing Visual Basic programs"
HOMEPAGE="http://www.emacswiki.org/emacs/VisualBasicMode"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"

SITEFILE="50${PN}-gentoo.el"
