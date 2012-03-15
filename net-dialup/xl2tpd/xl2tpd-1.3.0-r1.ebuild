# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="A modern version of the Layer 2 Tunneling Protocol (L2TP) daemon"
HOMEPAGE="http://www.xelerance.com/services/software/xl2tpd/"
SRC_URI="ftp://ftp.xelerance.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="dnsretry"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}
	net-dialup/ppp"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.3.0-0001-Add-kernel-support-for-2.6.23.patch
	epatch "${FILESDIR}"/${PN}-1.3.0-LDFLAGS.patch
	epatch "${FILESDIR}"/add-ctrl-retrans-opt.patch
	epatch "${FILESDIR}"/avp-workaround.patch
	epatch "${FILESDIR}"/make-rundir.patch
	epatch "${FILESDIR}"/multiple-interface.patch
	epatch "${FILESDIR}"/ebusy.patch
	epatch "${FILESDIR}"/kernelsrc.patch

	#epatch "${FILESDIR}"/${PN}-pppol2tp.patch
	#epatch "${FILESDIR}"/fix-pppol2tp.patch

	sed -i Makefile -e 's| -O2 ||g' || die "sed Makefile"
	use dnsretry && epatch "${FILESDIR}"/${PN}-dnsretry.patch
}

src_compile() {
	CC="$(tc-getCC)" emake
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install

	dodoc CREDITS README.xl2tpd \
		doc/README.patents doc/rfc2661.txt doc/*.sample

	dodir /etc/xl2tpd
	head -n 2 doc/l2tp-secrets.sample > "${D}/etc/xl2tpd/l2tp-secrets"
	fperms 0600 /etc/xl2tpd/l2tp-secrets
	newinitd "${FILESDIR}"/xl2tpd-init xl2tpd

	keepdir /var/run/xl2tpd
}
