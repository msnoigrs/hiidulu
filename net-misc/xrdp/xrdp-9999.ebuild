# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils autotools multilib user

if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/FreeRDP/xrdp.git"
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="mirror://sourceforge/${PN}/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~sparc ~x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

DESCRIPTION="An open source remote desktop protocol(rdp) server."
HOMEPAGE="http://www.xrdp.org/"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="+vnc x11rdp xorg-modules pulseaudio debug"

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}
	vnc? ( net-misc/tigervnc )
	x11rdp? ( >=x11-base/xorg-x11rdp-0.7.0.9999 )
	pulseaudio? ( media-sound/pulseaudio )
	"
RESTRICT="${RESTRICT}
	debug? ( strip )
	"

pkg_setup() {
	einfo "checking for necessary groups and users...  create if missing.\n"
	enewgroup tsusers  || die "problem adding group tsusers"
	enewgroup tsadmins || die "problem adding group tsadmins"
}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${A}
	fi
}

src_prepare() {
	epatch ${FILESDIR}/xrdpdev-9999.patch || die "epatch failed"
	cp ${FILESDIR}/startwm.sh ./sesman/
	cp ${FILESDIR}/xrdp-sesman-0.7.0.pamd ./instfiles/pam.d/xrdp-sesman
	sed -e 's:/usr/local/sbin:/usr/sbin:' -i ${S}/instfiles/xrdp.sh
	ln -s ../config.c ${S}/sesman/tools/config.c
	eautoreconf
	EXTRA_ECONF="--prefix=${EPREFIX}/usr --sysconfdir=${EPREFIX}/etc --localstatedir=${EPREFIX}/var --enable-fuse $(use_enable debug xrdpdebug)"
}

src_compile() {
	if use debug; then
		CFLAGS="${CFLAGS} -ggdb -O0"
	fi

	emake CFLAGS="${CFLAGS}" -j1 || die "compile failed"

	if use xorg-modules; then
		emake -C ${S}/xorg/server -j1 || die "compile xorg-modules failed"
	fi

	if use pulseaudio; then
		emake -C ${S}/sesman/chansrv/pulse || die "compile pulseaudio faield"
	fi
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
	dodoc design.txt readme.txt sesman/startwm.sh
	systemd_dounit "${FILESDIR}/xrdp-sesman.service"
	systemd_dounit "${FILESDIR}/xrdp.service"
	newinitd "${FILESDIR}/${PN}.initd" ${PN}

	if use xorg-modules; then
		into "/usr/lib/xorg/modules"
		insinto "${DESTTREE}"
		insopts "-m0755"
		doins "${S}/xorg/server/module/libxorgxrdp.so" || die
		insinto "${DESTTREE}/drivers"
		doins "${S}/xorg/server/xrdpdev/xrdpdev_drv.so" || die
		insinto "${DESTTREE}/input"
		doins "${S}/xorg/server/xrdpkeyb/xrdpkeyb_drv.so" || die
		doins "${S}/xorg/server/xrdpmouse/xrdpmouse_drv.so" || die
		into "/etc/X11/xrdp"
		insinto "${DESTTREE}"
		insopts "-m0644"
		doins "${S}/xorg/server/xrdpdev/xorg.conf" || die
	fi

	#http://opamp.hatenablog.jp/entry/2014/02/05/161522

	#http://241931348f64b1d1.wordpress.com/2013/05/27/how-to-compile-xrdpx11rdp-on-ubuntu/
	if use pulseaudio; then
		insinto "/usr/lib/pulse-5.0/modules"
		doins "${S}/sesman/chansrv/pulse/module-xrdp-sink.so" || die
	fi
}

pkg_postinst() {
	elog
	elog "After installation you must generate rsa key for xrdp"
	elog "\`xrdp-keygen xrdp auto\`"
	elog
}
