# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/mooz/js2-mode.git"

inherit elisp git-2

DESCRIPTION="Improved JavaScript editing mode for GNU Emacs"
HOMEPAGE="https://github.com/mooz/js2-mode"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
