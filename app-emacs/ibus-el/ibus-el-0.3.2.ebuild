# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit elisp

DESCRIPTION="ibus-mode"
HOMEPAGE="http://www11.atwiki.jp/s-irie/pages/21.html"
SRC_URI="http://launchpad.net/ibus.el/0.3/0.3.2/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-xlib"

#SITEFILE="60${PN}-gentoo.el"

src_install() {
	elisp_src_install
	exeinto "${SITELISP}/${PN}" || die
	doexe ibus-el-agent || die
}
