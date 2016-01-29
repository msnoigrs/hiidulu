# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/khws4v1/waifu2x-converter-qt.git"

inherit qmake-utils git-2

DESCRIPTION="Qt frontend of waifu2x"
HOMEPAGE="https://github.com/khws4v1/waifu2x-converter-qt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
LANGS="ja"
for l in ${LANGS}; do
	IUSE+=" linguas_${l}"
done

RDEPEND="media-gfx/waifu2x-converter-cpp
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s#a.applicationDirPath()#\"/usr/share/${PN}\"#" main.cpp
}

src_configure() {
	lupdate "${PN}".pro
	lrelease "${PN}".pro
	eqmake5
}

#src_compile() {
#	cmake-utils_src_make lupdate
#	cmake-utils_src_make lrelease
#	cmake-utils_src_make
#}

src_install() {
	dobin "${PN}"

	domenu "${FILESDIR}/${PN}.desktop"
	doicon "${FILESDIR}/waifu2x.png"

	for l in ${LANGS}; do
		if use linguas_${l}; then
			insinto "/usr/share/${PN}"
			doins "${PN}_${l}.qm"
		fi
	done
}
