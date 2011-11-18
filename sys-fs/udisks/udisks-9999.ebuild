# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://anongit.freedesktop.org/udisks"

inherit bash-completion gnome2-live
#inherit bash-completion autotools git-2

DESCRIPTION="Daemon providing interfaces to work with storage devices"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/udisks"
#SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="debug doc nls remote-access lvm2"


COMMON_DEPEND=">=sys-fs/udev-147[extras]
	>=dev-libs/glib-2.16.1:2
	>=sys-apps/dbus-1
	>=dev-libs/dbus-glib-0.82
	>=sys-auth/polkit-0.92
	>=sys-apps/parted-1.8.8[device-mapper]
	lvm2? ( >=sys-fs/lvm2-2.02.61 )
	>=dev-libs/libatasmart-0.14
	>=sys-apps/sg3_utils-1.27.20090411
	!sys-apps/devicekit-disks"
RDEPEND="${COMMON_DEPEND}
	remote-access? ( net-dns/avahi )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	doc? ( dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2 )
	nls? ( >=dev-util/intltool-0.40.0 )"

# This would require running dbus and also sudo.
RESTRICT="test"

#src_prepare() {
#	NOCONFIGURE="yes" ./autogen.sh
#}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}/var" \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		$(use_enable remote-access) \
		$(use_enable nls) \
		$(use_enable lvm2) \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS HACKING NEWS README

	rm -f "${D}"/etc/profile.d/udisks-bash-completion.sh
	dobashcompletion tools/udisks-bash-completion.sh ${PN}

	find "${ED}" -name '*.la' -delete
	keepdir /media
}
