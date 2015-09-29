# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="pdf2svg is based on poppler and cairo and can convert pdf to svg files"
HOMEPAGE="http://www.cityinthesky.co.uk/pdf2svg.html"
SRC_URI="https://github.com/db9052/pdf2svg/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-text/poppler-0.12.3-r3:=[cairo]
	>=x11-libs/cairo-1.2.6:=[svg]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e 's:#include <stdio.h>:#include <stdio.h>\n#include <stdlib.h>:' \
		${PN}.c || die
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog
}
