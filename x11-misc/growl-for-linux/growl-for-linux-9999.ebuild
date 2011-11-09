# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EGIT_REPO_URI="git://github.com/mattn/growl-for-linux.git"

inherit git-2 autotools multilib

DESCRIPTION="Growl Implementation For Linux"
#SRC_URI="https://github.com/downloads/mattn/growl-for-linux/${P}.tar.gz"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/openssl
	net-misc/curl
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	#epatch "${FILESDIR}/growl-for-linux-libnotify.patch"
	#./autogen.sh
	#elibtoolize
	mkdir m4
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die

	find "${ED}/usr/$(get_libdir)/growl-for-linux" -name "*.la" -exec rm {} + || die

	dodoc AUTHORS ChangeLog NEWS README* TODO || die
}
