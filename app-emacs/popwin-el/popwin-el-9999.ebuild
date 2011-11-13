# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://github.com/m2ym/popwin-el.git"

inherit elisp eutils git-2

DESCRIPTION="Auto-complete package"
HOMEPAGE="http://github.com/m2ym/popwin-el"
SRC_URI=""

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	rm popwin-test.el
}
