# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils qmake-utils toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	KEYWORDS="amd64 ~arm hppa ia64 ppc ppc64 x86 ~amd64-fbsd"
	EGIT_REPO_URI="https://github.com/codestation/qcma.git"
	inherit git-2
else
	KEYWORDS="amd64 ~arm hppa ia64 ppc ppc64 x86 ~amd64-fbsd"
	SRC_URI="https://github.com/codestation/qcma/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/qcma-${PV}"
fi

DESCRIPTION="the original Content Manager Assistant that comes with the PS Vita."
HOMEPAGE="https://github.com/codestation/qcma"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:5
	dev-qt/qtsql:5
	media-libs/libvitamtp"
RDEPEND="${DEPEND}
	virtual/ffmpeg"

src_prepare() {
	epatch "${FILESDIR}"/ffmpeg.patch
	sed -i -e 's/qcma.png/qcma/' -e '/^Path=/ d' gui/resources/qcma.desktop
}

src_configure() {
	lrelease common/resources/translations/*.ts
	eqmake5 PREFIX="${EPREFIX}/usr" qcma.pro CONFIG+="QT5_SUFFIX ENABLE_KNOTIFICATIONS ENABLE_APPINDICATOR ENABLE_KDENOTIFIER"
}

src_install() {
#	qt5_src_install
	#dobin qvv || die "dobin failed"
	#doicon images/qvv_icon_128x128.png || die "doicon failed"
	#make_desktop_entry qvv QVV qvv_icon_128x128
	#dodoc ANFSCD GPG_README HISTORY README todo.txt || die "dodoc failed"

	dobin qcma
}
