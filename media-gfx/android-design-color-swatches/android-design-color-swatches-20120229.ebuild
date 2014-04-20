# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_PN="Android_Design_Color_Swatches"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Setup Android Color Palettes for Gimp and InkScape"
HOMEPAGE="http://developer.android.com/design/style/color.html"
SRC_URI="http://developer.android.com/downloads/design/${MY_P}.zip"

LICENSE="CC-BY-2.5"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+gimp +inkscape"

RDEPEND="gimp? ( media-gfx/gimp )
	inkscape? ( media-gfx/inkscape )"
DEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	if use gimp; then
		insinto /usr/share/gimp/2.0/palettes
		doins android-ics.gpl
	fi
	if use inkscape; then
		insinto /usr/share/inkscape/palettes
		doins android-ics.gpl
	fi
	dodoc values.txt
}
