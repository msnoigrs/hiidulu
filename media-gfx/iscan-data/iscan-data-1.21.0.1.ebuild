# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils versionator

MY_PV="$(replace_version_separator 3 '-')"
S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"
EPSON_URI="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"

DESCRIPTION="Image Scan! for Linux data files"
HOMEPAGE="http://avasys.jp/english/linux_e/"
SRC_URI="${PN}_${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"

DEPEND="dev-libs/libxslt"
RDEPEND="${DEPEND}"

pkg_nofetch() {
        einfo "Please download ${PN}_${MY_PV}.tar.gz from:"
        einfo "${EPSON_URI}"
        einfo "and move it to ${DISTDIR}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# create udev rules
	dodir /lib/udev/rules.d
	"${D}usr/lib64/iscan-data/make-policy-file" \
		--force --quiet --mode udev \
		-d "${D}usr/share/iscan-data/epkowa.desc" \
		-o "${D}lib/udev/rules.d/99-iscan.rules"

	# install docs
	dodoc NEWS SUPPORTED-DEVICES KNOWN-PROBLEMS
}
