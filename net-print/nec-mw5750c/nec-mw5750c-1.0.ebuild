# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils rpm

RPMPKG="NEC-MultiWriter_5750C-${PV}-1.i386.rpm"

DESCRIPTION="NEC MultiWriter XRC Printer Driver for Linux"
HOMEPAGE="http://jpn.nec.com/printer/laser/support/os/linux/download/mw5750c.html"
SRC_URI="http://jpn.nec.com/printer/laser/support/os/linux/download/data/xrc-driver/mw5750c/${RPMPKG}"
#SRC_URI="http://jpn.nec.com/printer/laser/support/os/linux/download/data/xrc-driver/mw5750c/${RPMPKG}
#	http://www.nec.co.jp/products/laser/support/os/linux/download/data/xrc-driver/mw5750c/ncprefilter-1.0.0.tar.gz"

LICENSE="UNKNOWN"
SLOT="0"
KEYWORDS="x86 amd64"
RESTRICT="mirror strip"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}"

src_prepare() {
	sed -i -e 's#/usr/lib/cups#/usr/libexec/cups#g' \
		-e 's#/usr/share/cups/FujiXerox#/usr/share/cups/NEC#' \
		usr/share/cups/model/NEC/NEC_MultiWriter_5750C.ppd
}

src_compile() {
	#cd ncprefilter-1.0.0/filter
	#tc-export CC
	#emake
	:;
}

src_install() {
	#rm "${S}/usr/lib/cups/filter/NEC_MultiWriter_5750C/NCM_PF"

	dodir /usr/libexec/cups/filter/
	insinto /usr/libexec/cups/filter/
	doins -r "${S}/usr/lib/cups/filter/NEC_MultiWriter_5750C"

	#insinto /usr/libexec/cups/filter/NEC_MultiWriter_5750C/
	#doins "${S}/ncprefilter-1.0.0/filter/NCM_PF"

	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_ALC
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_CC
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_HBPL
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_MF
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_PF
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_PM2FXR
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_PR
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_PS2PM
	fperms 0755 /usr/libexec/cups/filter/NEC_MultiWriter_5750C/NCM_SBP

	dodir /usr/share/cups/model
	insinto /usr/share/cups/
	doins -r "${S}/usr/share/cups/NEC"
	insinto /usr/share/cups/model
	doins -r "${S}/usr/share/cups/model/NEC"
}
