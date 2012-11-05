# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/kinjo/org-impress-js.el.git"

inherit elisp git-2

DESCRIPTION="impress.js export for Org-mode"
HOMEPAGE="https://github.com/kinjo/org-impress-js.el"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins mystyle.css
	elisp_src_install
}
