# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="python? 2:2.5"

EGIT_REPO_URI="git://github.com/ibus/ibus.git"

inherit confutils eutils gnome2-utils multilib python git-2 autotools

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
#SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc +gconf gtk2 gtk3 introspection nls +python vala X"

RDEPEND=">=dev-libs/glib-2.26
	gconf? ( >=gnome-base/gconf-2.12 )
	>=gnome-base/librsvg-2
	sys-apps/dbus
	app-text/iso-codes
	gtk2? (
		x11-libs/gtk+:2
	)
	gtk3? (
		x11-libs/gtk+:3
	)
	X? (
		x11-libs/libX11
		x11-libs/gtk+:2
		x11-libs/gtk+:3
	)
	introspection? ( >=dev-libs/gobject-introspection-0.6.8 )
	python? (
		dev-python/notify-python
		>=dev-python/dbus-python-0.83
	)
	nls? ( virtual/libintl )"
#	X? ( x11-libs/libX11 )
#	gtk? ( x11-libs/gtk+:2 x11-libs/gtk+:3 )
#	vala? ( dev-lang/vala )
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.1
	dev-perl/XML-Parser
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	python? (
		dev-python/pygtk
		dev-python/pyxdg
	)"

RESTRICT="test"

update_gtk_immodules() {
	if use gtk2; then
		local GTK2_CONFDIR="/etc/gtk-2.0"
		# An arch specific config directory is used on multilib systems
		has_multilib_profile && GTK2_CONFDIR="${GTK2_CONFDIR}/${CHOST}"
		mkdir -p "${EPREFIX}${GTK2_CONFDIR}"

		if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ] ; then
			"${EPREFIX}/usr/bin/gtk-query-immodules-2.0" > "${EPREFIX}${GTK2_CONFDIR}/gtk.immodules"
		fi
	fi
	if use gtk3; then
#		local GTK3_CONFDIR="/etc/gtk-3.0"
		# An arch specific config directory is used on multilib systems
#		has_multilib_profile && GTK3_CONFDIR="${GTK3_CONFDIR}/${CHOST}"
#		mkdir -p "${EPREFIX}${GTK3_CONFDIR}"

		if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-3.0" ] ; then
			#"${EPREFIX}/usr/bin/gtk-query-immodules-3.0" > "${EPREFIX}${GTK3_CONFDIR}/gtk.immodules"
			"${EPREFIX}/usr/bin/gtk-query-immodules-3.0" --update-cache
		fi
	fi
}

pkg_setup() {
	# bug #342903
	confutils_require_any X gtk2 gtk3
	python_set_active_version 2
}

src_prepare() {
	#sed -i -e 's/\-Werror//' autogen.sh
	#NOCONFIGURE=1 ./autogen.sh

	echo "AM_GNU_GETTEXT_VERSION(0.16.1)" >> "${S}"/configure.ac
		autopoint || die "autopoint failed"
		intltoolize --copy --force || die "intltoolize failed"
		gtkdocize --copy || die "gtkdocize failed"
		eautoreconf

#	mv py-compile py-compile.orig || die
#	ln -s "$(type -P true)" py-compile || die
	echo "ibus/_config.py" >> po/POTFILES.skip || die
	sed -i -e "s/python/python2/" setup/ibus-setup.in ui/gtk/ibus-ui-gtk.in || die
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable doc gtk-doc-html) \
		$(use_enable introspection) \
		$(use_enable gconf) \
		$(use_enable gtk2) \
		$(use_enable nls) \
		$(use_enable python) \
		$(use_enable vala) \
		$(use_enable X xim) \
		$(use_enable gtk3) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	insinto /etc/X11/xinit/xinput.d
	newins xinput-ibus ibus.conf || die

	# bug 289547
	keepdir /usr/share/ibus/{engine,icons} || die

	#dodoc AUTHORS ChangeLog NEWS README || die
	dodoc AUTHORS NEWS README || die
}

pkg_preinst() {
	use gconf && gnome2_gconf_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	use gconf && gnome2_gconf_install
	if use gtk2 || use gtk3; then
		update_gtk_immodules
	fi
	use python && python_mod_optimize /usr/share/${PN}
	gnome2_icon_cache_update

	elog "To use ibus, you should:"
	elog "1. Get input engines from sunrise overlay."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of packages we already have."
	elog
	elog "2. Setup ibus:"
	elog
	elog "   $ ibus-setup"
	elog
	elog "3. Set the following in your user startup scripts"
	elog "   such as .xinitrc, .xsession or .xprofile:"
	elog
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"xim\""
	elog "   ibus-daemon -d -x"
}

pkg_postrm() {
	if use gtk2 || gtk3; then
		update_gtk_immodules
	fi
	use python && python_mod_cleanup /usr/share/${PN}
	gnome2_icon_cache_update
}
