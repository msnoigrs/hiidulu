# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

EGIT_REPO_URI="git://git.gnome.org/libnotify"

#inherit git autotools eutils gnome.org
inherit gnome2 gnome2-live

DESCRIPTION="Notifications library"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI=""
#	mirror://gentoo/introspection-20110205.m4.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc +introspection test"

RDEPEND=">=dev-libs/glib-2.26:2
	x11-libs/gdk-pixbuf:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.14 )
	test? ( >=x11-libs/gtk+-2.90:3 )"
PDEPEND="virtual/notification-daemon"

#src_unpack() {
	# If gobject-introspection is installed, we don't need the extra .m4
#	if has_version "dev-libs/gobject-introspection"; then
#		git_src_unpack
#	else
#		git_src_unpack
#		unpack ${A}
#	fi
#}

#src_prepare() {
	# Add configure switch for gtk+:3 based tests
	# and make tests build only when needed
#	epatch "${FILESDIR}"/${PN}-0.7.1-gtk3-tests.patch

#	AT_M4DIR=${WORKDIR} eautoreconf
#}

#src_configure() {
pkg_setup() {
	G2CONF="${G2CONF} \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable introspection)"
	DOCS="AUTHORS ChangeLog NEWS"
}

#src_install() {
#	emake install DESTDIR="${D}" || die
#	dodoc AUTHORS ChangeLog NEWS || die

#	find "${ED}" -name '*.la' -exec rm -f {} +
#}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libnotify.so.1
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libnotify.so.1
}