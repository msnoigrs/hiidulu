# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

ECVS_SERVER="cvs.savannah.gnu.org:/sources/classpath"
ECVS_MODULE="classpath"

inherit autotools eutils cvs flag-o-matic multilib java-pkg-2

MY_PN=${PN/gnu-/}
DESCRIPTION="Free core class libraries for use with VMs and compilers for the Java programming language"
#SRC_URI="mirror://gnu/classpath/${MY_P}.tar.gz"
SRC_URI=""
HOMEPAGE="http://www.gnu.org/software/classpath"

LICENSE="GPL-2-with-linking-exception"
SLOT="0.98"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
#KEYWORDS=""

IUSE="alsa debug doc dssi examples gconf gjdoc gmp gtk gstreamer qt4 xml"

RDEPEND="alsa? ( media-libs/alsa-lib )
		doc? ( >=dev-java/gjdoc-0.7.9-r2 )
		dssi? ( >=media-libs/dssi-0.9 )
		gconf? ( gnome-base/gconf )
		gjdoc? ( >=dev-java/antlr-2.7.1:0 )
		gmp? ( >=dev-libs/gmp-4.2.4 )
		gstreamer? (
			>=media-libs/gstreamer-0.10.10
			>=media-libs/gst-plugins-base-0.10.10
			x11-libs/gtk+
		)
		gtk? (
				>=x11-libs/gtk+-2.8
				>=dev-libs/glib-2.0
				media-libs/freetype
				>=x11-libs/cairo-1.1.9
				x11-libs/libICE
				x11-libs/libSM
				x11-libs/libX11
				x11-libs/libXrandr
				x11-libs/libXrender
				x11-libs/libXtst
				x11-libs/pango
		)
		qt4? ( dev-qt/qtgui:4 )
		xml? ( >=dev-libs/libxml2-2.6.8 >=dev-libs/libxslt-1.1.11 )"

# java-config >2.1.11 needed for ecj version globbing
# We should make the build not pickup the wrong antlr binary from pccts
DEPEND="app-arch/zip
		dev-java/eclipse-ecj
		>=dev-java/java-config-2.1.11
		gjdoc? ( !!dev-util/pccts )
		gtk? (
			x11-libs/libXrender
			|| ( >=x11-libs/libXtst-1.1.0 <x11-proto/xextproto-7.1 )
			x11-proto/xproto
		)
		>=virtual/jdk-1.5
		${RDEPEND}"

RDEPEND=">=virtual/jre-1.5
	${RDEPEND}"

S=${WORKDIR}/${MY_PN}

java_prepare() {
	epatch "${FILESDIR}/fix-texinfo.patch"
	sed -i -e 's#freetype/#freetype2/#g' native/jni/gtk-peer/gnu_java_awt_peer_gtk_FreetypeGlyphVector.c
	sed -i -e 's#freetype/#freetype2/#g' native/jni/gtk-peer/gnu_java_awt_peer_gtk_GdkFontPeer.c
	eautoreconf
}

src_configure() {
	# We require ecj anyway, so force it to avoid problems with bad versions of javac
	export JAVAC="/usr/bin/ecj"
	export JAVA="/usr/bin/java"
	# build takes care of them itself, duplicate -source -target kills ecj
	export JAVACFLAGS="-nowarn"
	# build system is passing -J-Xmx768M which ecj however ignores
	# this will make the ecj launcher do it (seen case where default was not enough heap)
	export gjl_java_args="-Xmx768M"

	# don't use econf, because it ends up putting things under /usr, which may
	# collide with other slots of classpath
	local myconf
	if use gjdoc; then
		local antlr=$(java-pkg_getjar antlr antlr.jar)
		myconf="--with-antlr-jar=${antlr}"
	fi

	ANTLR= ./configure \
		$(use_enable alsa) \
		$(use_enable debug ) \
		$(use_enable examples) \
		$(use_enable gconf gconf-peer) \
		$(use_enable gjdoc) \
		$(use_enable gmp) \
		$(use_enable gtk gtk-peer) \
		$(use_enable gstreamer gstreamer-peer) \
		$(use_enable qt4 qt-peer) \
		$(use_enable xml xmlj) \
		$(use_enable dssi ) \
		$(use_with doc gjdoc) \
		--enable-jni \
		--disable-dependency-tracking \
		--disable-plugin \
		--host=${CHOST} \
		--prefix=/usr/${PN}-${SLOT} \
		--with-ecj-jar=$(java-pkg_getjar --build-only eclipse-ecj-* ecj.jar) \
		--disable-Werror \
		${myconf} \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
	dodoc AUTHORS BUGS ChangeLog* HACKING NEWS README THANKYOU TODO || die
	java-pkg_regjar /usr/${PN}-${SLOT}/share/classpath/glibj.zip
}
