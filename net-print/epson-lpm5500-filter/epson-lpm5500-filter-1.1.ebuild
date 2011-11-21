# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools

MY_PN="Epson-LPM5500-filter"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Epson LPM5500/LPM5600 filter"
HOMEPAGE="http://avasys.jp/"
SRC_URI="${MY_P}.tar.gz"

LICENSE="EAPL MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cups"
RESTRICT="fetch strip"

COMMON_DEPEND="cups? ( net-print/cups
	net-print/foomatic-filters-ppds )
	net-print/foomatic-filters[cups?]"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	app-text/psutils"

S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	einfo "Please download ${MY_PN}.tar.gz from:"
	einfo "http://www.avasys.jp/lx-bin2/linux/mfp/DL2.do"
	einfo "and move it to ${DISTDIR}"
}

src_prepare() {
	eaclocal
	eautoconf
}

src_compile() {
	if ! use cups; then
		sed -i -e '/ppd/d' Makefile || die
	fi
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Compress the PPD files:
	for ppd in "${D}"/usr/share/cups/model/*.ppd; do
		gzip "${ppd}" || die
	done

	keepdir /etc/epkowa/lpm5500 /etc/epkowa/lpm5600
	dodoc EAPL.en.txt EAPL.ja.txt README README-lpm5500.ja
	use cups && dodoc README-lpm5500-CUPS.ja
}
