# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils rpm

RPMPKG="NEC-MultiWriter_5750C-${PV}-1.i386.rpm"

DESCRIPTION="NEC MultiWriter XRC Printer Driver for Linux"
HOMEPAGE="http://jpn.nec.com/printer/laser/support/os/linux/download/mw5750c.html"
#SRC_URI="http://jpn.nec.com/printer/laser/support/os/linux/download/data/xrc-driver/mw5750c/${DEBPKG}"
SRC_URI="http://jpn.nec.com/printer/laser/support/os/linux/download/data/xrc-driver/mw5750c/${RPMPKG}"

LICENSE="UNKNOWN"
SLOT="0"
KEYWORDS="x86 amd64"
RESTRICT="mirror strip"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}"

src_compile() {
	:;
}

src_install() {
	dodir /usr/libexec/cups/filter/
	insinto /usr/libexec/cups/filter/
	doins -r "${S}/usr/lib/cups/filter/NEC_MultiWriter_5750C"

	dodir /usr/share/cups/model
	insinto /usr/share/cups/
	doins -r "${S}/usr/share/cups/NEC"
	insinto /usr/share/cups/model
	doins -r "${S}/usr/share/cups/model/NEC"
}
