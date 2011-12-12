# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

#ECVS_SERVER="cvs.freedesktop.org:/cvs/xklavier"
#ECVS_MODULE="libxklavier"
#ECVS_USER="anoncvs"
#ECVS_PASS="anoncvs"

EGIT_REPO_URI="git://anongit.freedesktop.org/libxklavier"

inherit autotools multilib gnome2-live

DESCRIPTION="High level XKB library"
HOMEPAGE="http://www.freedesktop.org/Software/LibXklavier"
#SRC_URI="mirror://sourceforge/gswitchit/${P}.tar.bz2"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND="x11-misc/xkeyboard-config
	x11-libs/libX11
	>=x11-libs/libXi-1.1.3
	x11-apps/xkbcomp
	x11-libs/libxkbfile
	>=dev-libs/glib-2.16:2
	dev-libs/libxml2
	app-text/iso-codes"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.4 )"

#S="${WORKDIR}"/${PN}

#src_prepare() {
#	cd "${WORKDIR}"/${PN}
#	NOCONFIGURE=1 ./autogen.sh || die
	#elibtoolize
#	eautoreconf
#}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--with-xkb-base="${EPREFIX}/usr/share/X11/xkb" \
		--with-xkb-bin-base="${EPREFIX}/usr/bin" \
		$(use_enable doc gtk-doc)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog CREDITS NEWS README || die
	find "${D}" -name "*.la" -delete || die "remove of la files failed"
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libxklavier.so.15
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libxklavier.so.15
}
