# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils qt4-r2

DESCRIPTION="the original Content Manager Assistant that comes with the PS Vita."
HOMEPAGE="https://github.com/codestation/qcma"
SRC_URI="https://github.com/codestation/qcma/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:4
	dev-qt/qtsql:4
	media-libs/libvitamtp"
RDEPEND="${DEPEND}
	virtual/ffmpeg"

src_prepare() {
	sed -i -e 's/qcma.png/qcma/' -e '/^Path=/ d' resources/qcma.desktop
}

src_configure() {
	lrelease resources/translations/*.ts
	eqmake4 PREFIX="${EPREFIX}/usr"
}

src_install() {
	qt4-r2_src_install
	#dobin qvv || die "dobin failed"
	#doicon images/qvv_icon_128x128.png || die "doicon failed"
	#make_desktop_entry qvv QVV qvv_icon_128x128
	#dodoc ANFSCD GPG_README HISTORY README todo.txt || die "dodoc failed"
}
