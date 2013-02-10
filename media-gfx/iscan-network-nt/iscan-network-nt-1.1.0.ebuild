# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib rpm

SRC_REV="2" # Revision used by upstream.
EPSON_URI="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
# PX-502A

DESCRIPTION="Image Scan! for Linux network plugin"
HOMEPAGE="http://global.epson.com/"
SRC_URI="
	amd64? ( ${P}-${SRC_REV}.x86_64.rpm )
	x86?   ( ${P}-${SRC_REV}.i386.rpm )"

LICENSE="AVASYS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

QA_PRESTRIPPED="usr/libexec/iscan/network"

RESTRICT="fetch strip"

RDEPEND="media-gfx/iscan"
DEPEND="${RDEPEND}"

S="${WORKDIR}/usr"

pkg_nofetch() {
        einfo "Please download ${SRC_URI} from:"
        einfo "${EPSON_URI}"
        einfo "and move it to ${DISTDIR}"
}

src_install() {
	# Install plugin:
	exeinto /usr/$(get_libdir)/iscan
	doexe $(get_libdir)/iscan/network

	# Install documentation:
	dodoc share/doc/"${PF}"/{NEWS,README}
}
