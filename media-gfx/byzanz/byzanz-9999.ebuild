# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"

EGIT_REPO_URI="https://github.com/GNOME/byzanz.git"

inherit gnome2 git-2

DESCRIPTION="Screencasting program that saves casts as GIF files"
HOMEPAGE="http://people.freedesktop.org/~company/byzanz/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	x11-libs/libXdamage
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-3.2:3
	gnome-base/gconf
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	x11-libs/cairo
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.50
	x11-proto/damageproto
"
RDEPEND="${COMMON_DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}/Fix-FTBFS-because-of-Wcast-align-error-flag.patch"
	epatch "${FILESDIR}/audio.patch"
	epatch "${FILESDIR}/no-Werror.patch"

	sh autogen.sh
	gnome2_src_prepare

	# FIXME: gst macros does not take GST_INSPECT override anymore but we need a
	# way to disable inspection due to gst-clutter always creating a GL context
	# which is forbidden in sandbox since it needs write access to
	# /dev/card*/dri
	#sed -e "s|\(gstinspect=\).*|\1$(type -P true)|" \
	#	-i configure || die
}

src_configure() {
	gnome2_src_configure ITSTOOLS="$(type -P true)"
}

pkg_postinst() {
	gnome2_pkg_postinst
	if [ -z ${REPLACING_VERSIONS} ]; then
		ewarn "The list of audio encoding profiles in ${P} is non-customizable."
		ewarn "A possible workaround is to rip to flac using ${PN}, and convert to"
		ewarn "your desired format using a separate tool."
	fi
}
