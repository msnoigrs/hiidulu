# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
WANT_AUTOCONF="2.1"

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib autotools versionator pax-utils prefix python-utils-r1

MAJ_XUL_PV="$(get_version_component_range 1-2)" # from mozilla-* branch name
MAJ_FF_PV="4.0"
FF_PV="${PV/${MAJ_XUL_PV}/${MAJ_FF_PV}}" # 3.7_alpha6, 3.6.3, etc.
FF_PV="${FF_PV/_alpha/a}" # Handle alpha for SRC_URI
FF_PV="${FF_PV/_beta/b}" # Handle beta for SRC_URI
FF_PV="${FF_PV/_rc/rc}" # Handle rc for SRC_URI
CHANGESET="e56ecd8b3a68"
PATCH="${PN}-2.0-patches-1.8"

DESCRIPTION="Mozilla runtime package that can be used to bootstrap XUL+XPCOM applications"
HOMEPAGE="http://developer.mozilla.org/en/docs/XULRunner"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
SLOT="1.9"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="+crashreporter gconf +ipc system-sqlite +webm"

REL_URI="ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases"
# More URIs appended below...
#SRC_URI="http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCH}.tar.bz2"
MY_TARBALL="xulrunner-2.0-patches-1.8.tar.bz2"
SRC_URI="http://osdn.jp/frs/chamber_redir.php?m=iij&f=%2Fusers%2F9%2F9548%2F${MY_TARBALL}"

ASM_DEPEND=">=dev-lang/yasm-1.1.0"

RDEPEND="
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.9
	>=dev-libs/nspr-4.8.7
	>=dev-libs/glib-2.26
	gconf? ( >=gnome-base/gconf-1.2.1:2 )
	media-libs/libpng[apng]
	virtual/libffi
	system-sqlite? ( >=dev-db/sqlite-3.7.4[fts3,secure-delete,unlock-notify,debug=] )
	webm? ( media-libs/libvpx
		media-libs/alsa-lib
		media-libs/mesa )
	!www-plugins/weave"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	webm? ( amd64? ( ${ASM_DEPEND} )
		x86? ( ${ASM_DEPEND} ) )"

if [[ ${PV} =~ alpha|beta ]]; then
	# hg snapshot tarball
	SRC_URI="${SRC_URI}
		http://dev.gentoo.org/~anarchy/mozilla/firefox/firefox-${FF_PV}_${CHANGESET}.source.tar.bz2"
	S="${WORKDIR}/mozilla-central"
else
	SRC_URI="${SRC_URI}
		${REL_URI}/${FF_PV}/source/firefox-${FF_PV}.source.tar.bz2"
	S="${WORKDIR}/mozilla-${MAJ_XUL_PV}"
fi

pkg_setup() {
	moz_pkgsetup
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"

	#64bit big endian support
	epatch "${FILESDIR}/mozilla-2.0_support_64bit_big_endian.patch"

	# Patches needed for ARM, bug 362237
	epatch "${FILESDIR}/arm-bug-644136.patch"
	epatch "${FILESDIR}/mozilla-2.0_arm_respect_cflags.patch"

	# Allow to build without alsa USE-flag,bug #360163
	epatch "${FILESDIR}/bug-626229.patch"

	# http://pkgsrc.se/files.php?messageId=20140427075401.C901F96@cvs.netbsd.org
	#http://www.mirrorservice.org/pub/pkgsrc/stable/pkgsrc/devel/xulrunner192/patches/
	epatch "${FILESDIR}/gfx_ots_src_os2.cc.patch"
	epatch "${FILESDIR}/nsSVGFilters.cpp.patch"
	epatch "${FILESDIR}/nsSVGFilters.h.patch"
	epatch "${FILESDIR}/nsDOMWorkerEvents.cpp.patch"
	epatch "${FILESDIR}/nsDOMWorkerEvents.h.patch"
	epatch "${FILESDIR}/make-system-wrappers.pl.patch"

	#http://www.linuxfromscratch.org/pipermail/blfs-dev/2013-November/026134.html
	epatch "${FILESDIR}/system-headers.patch"

	# Allow user to apply any additional patches without modifing ebuild
	epatch_user

	eprefixify \
		extensions/java/xpcom/interfaces/org/mozilla/xpcom/Mozilla.java \
		xpcom/build/nsXPCOMPrivate.h \
		xulrunner/installer/Makefile.in \
		xulrunner/app/nsRegisterGREUnix.cpp

	# fix double symbols due to double -ljemalloc
	sed -i -e '/^LIBS += $(JEMALLOC_LIBS)/s/^/#/' \
		xulrunner/stub/Makefile.in || die

	#Fix compilation with curl-7.21.7 bug 376027
	sed -e '/#include <curl\/types\.h>/d' \
		-i "${S}"/toolkit/crashreporter/google-breakpad/src/common/linux/libcurl_wrapper.cc \
		-i "${S}"/toolkit/crashreporter/google-breakpad/src/common/linux/http_upload.cc \
			|| die
	sed -e '/curl\/types\.h/d' \
		-i "${S}"/config/system-headers \
		-i "${S}"/js/src/config/system-headers \
			|| die

	# Same as in config/autoconf.mk.in
	MOZLIBDIR="/usr/$(get_libdir)/${PN}-${MAJ_XUL_PV}"
	SDKDIR="/usr/$(get_libdir)/${PN}-devel-${MAJ_XUL_PV}/sdk"

	# Gentoo install dirs
	sed -i -e "s:@PV@:${MAJ_XUL_PV}:" "${S}"/config/autoconf.mk.in \
		|| die "${MAJ_XUL_PV} sed failed!"

	# Enable gnomebreakpad
	if use debug ; then
		sed -i -e "s:GNOME_DISABLE_CRASH_DIALOG=1:GNOME_DISABLE_CRASH_DIALOG=0:g" \
			"${S}"/build/unix/run-mozilla.sh || die "sed failed!"
	fi

	# Disable gnomevfs extension
	sed -i -e "s:gnomevfs::" "${S}/"xulrunner/confvars.sh \
		|| die "Failed to remove gnomevfs extension"

	# gcc-4.7 patch
	epatch "${FILESDIR}/${P}-gcc47.patch"

	epatch "${FILESDIR}/libffi-config.patch"

	eautoreconf

	cd js/src
	AT_NOELIBTOOLIZE=yes eautoreconf
}

src_configure() {
	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	MEXTENSIONS="default"

	MOZLIBDIR="/usr/$(get_libdir)/${PN}-${MAJ_XUL_PV}"

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	mozconfig_annotate '' --with-default-mozilla-five-home="${MOZLIBDIR}"
	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --disable-mailnews
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --enable-safe-browsing
	mozconfig_annotate '' --with-system-png
	mozconfig_annotate '' --enable-system-ffi
	mozconfig_use_enable system-sqlite
	mozconfig_use_enable gconf

	# Finalize and report settings
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-flags -fno-stack-protector
	fi

	# Ensure we do not fail on i{3,5,7} processors that support -mavx
	if use amd64 || use x86; then
		append-flags -mno-avx
	fi

	####################################
	#
	#  Configure and build
	#
	####################################

	# Disable no-print-directory
	MAKEOPTS=${MAKEOPTS/--no-print-directory/}

	# Ensure that are plugins dir is enabled as default
	sed -i -e "s:/usr/lib/mozilla/plugins:/usr/$(get_libdir)/nsbrowser/plugins:" \
		"${S}"/xpcom/io/nsAppFileLocationProvider.cpp || die "sed failed to replace plugin path!"

	# hack added to workaround bug 299905 on hosts with libc that doesn't
	# support tls, (probably will only hit this condition with Gentoo Prefix)
	tc-has-tls -l || export ac_cv_thread_keyword=no

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" PYTHON="${PYTHON}" econf
}

src_install() {
	# Add our defaults to xulrunner and out of firefox
	cp "${FILESDIR}"/xulrunner-default-prefs.js \
		"${S}/dist/bin/defaults/pref/all-gentoo.js" || \
			die "failed to cp xulrunner-default-prefs.js"

	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${ED}"/usr/bin/xulrunner

	MOZLIBDIR="/usr/$(get_libdir)/${PN}-${MAJ_XUL_PV}"
	SDKDIR="/usr/$(get_libdir)/${PN}-devel-${MAJ_XUL_PV}/sdk"

	if has_multilib_profile; then
		local config
		for config in "${ED}"/etc/gre.d/*.system.conf ; do
			mv "${config}" "${config%.conf}.${CHOST}.conf"
		done
	fi

	dodir /usr/bin
	dosym "${MOZLIBDIR}/xulrunner" "/usr/bin/xulrunner-${MAJ_XUL_PV}" || die

	# env.d file for ld search path
	dodir /etc/env.d
	echo "LDPATH=${EPREFIX}/${MOZLIBDIR}" > "${ED}"/etc/env.d/08xulrunner || die "env.d failed"

	pax-mark m "${ED}"/${MOZLIBDIR}/plugin-container
}
