# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/pgundlach/LuaTeX.git"

inherit git-2 libtool eutils

DESCRIPTION="An extended version of pdfTeX using Lua as an embedded scripting language."
HOMEPAGE="http://www.luatex.org/"
#SRC_URI="http://foundry.supelec.fr/gf/download/frsrelease/392/1730/${PN}-beta-${PV}.tar.bz2
#	http://foundry.supelec.fr/gf/download/frsrelease/392/1732/${PN}-beta-${PV}-doc.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc"

RDEPEND="dev-libs/zziplib
	>=media-libs/libpng-1.4
	>=app-text/poppler-0.12.3-r3[xpdf-headers]
	sys-libs/zlib
	>=dev-libs/kpathsea-6.0.1_p20110627"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#S="${WORKDIR}/${PN}-beta-${PV}/source"
#PRELIBS="libs/obsdcompat"
#texk/kpathsea"
#kpathsea_extraconf="--disable-shared --disable-largefile"

B="build-${ARCH}"

src_prepare() {
#	has_version '>=app-text/poppler-0.18.0:0' && epatch "${FILESDIR}/poppler018.patch"
	mkdir ${B}

	( cd source; ./texk/web2c/luatexdir/getluatexsvnversion.sh )
	#S="${S}/build-aux" elibtoolize --shallow
}

src_configure() {
	cd ${B}

	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #244619
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

#	local myconf
#	myconf=""
	#has_version '>=app-text/texlive-core-2009' && myconf="--with-system-kpathsea"

	cd "${S}/texk/web2c"
	../source/configure \
		--disable-cxx-runtime-hack \
		--disable-all-pkgs	\
		--disable-shared	\
		--disable-largefile \
		--disable-ptex		\
		--disable-ipc		\
		--enable-dump-share	\
		--enable-mp		\
		--enable-luatex		\
		--with-system-ptexenc \
		--with-system-kpathsea	\
		--with-system-poppler \
		--with-system-xpdf \
		--with-system-freetype \
		--with-system-freetype2 \
		--with-system-gd	\
		--with-system-libpng	\
		--with-system-teckit \
		--with-system-zlib \
		--with-system-t1lib \
		--with-system-icu \
		--with-system-graphite \
		--with-system-zziplib \
		--without-mf-x-toolkit \
		--without-x || die "failed to configure"

#	for i in ${PRELIBS} ; do
#		einfo "Configuring $i"
#		local j=$(basename $i)_extraconf
#		local myconf
#		eval myconf=\${$j}
#		cd "${S}/${i}"
#		econf ${myconf}
#	done
}

src_compile() {
	cd ${B}
#	cd source

#	texk/web2c/luatexdir/getluatexsvnversion.sh || die
#	for i in ${PRELIBS} ; do
#		cd "${S}/${i}"
#		emake || die "failed to build ${i}"
#	done
	#cd "${WORKDIR}/${PN}-beta-${PV}/source/texk/web2c"
#	cd "${S}/source/texk/web2c"
#	emake luatex || die "failed to build luatex"
	emake
	( cd texk/web2c; emake luatex )
}

src_install() {
	cd ${B}
	#cd "${WORKDIR}/${PN}-beta-${PV}/source/texk/web2c"
	#cd "${S}/source/texk/web2c"
#	emake DESTDIR="${D}" bin_PROGRAMS="luatex" SUBDIRS="" nodist_man_MANS="" \
#		install-exec-am || die
#	emake dist
#	( cd texk/web2c; emake dist )

	dobin texk/web2c/luatex
	dosym /usr/bin/luatex /usr/bin/texlua
	dosym /usr/bin/luatex /usr/bin/texluac

	#dodoc "${WORKDIR}/${PN}-beta-${PV}/README" || die
	dodoc "${S}/README" || die
#	doman "${WORKDIR}/texmf/doc/man/man1/"*.1 || die
	if use doc ; then
		#dodoc "${WORKDIR}/${PN}-beta-${PV}/manual/"*.pdf || die
		dodoc "${S}/manual/"*.pdf || die
#		dodoc "${WORKDIR}/texmf/doc/man/man1/"*.pdf || die
	fi
}

pkg_postinst() {
	if ! has_version '>=dev-texlive/texlive-basic-2008' ; then
		elog "Please note that this package does not install much files, mainly the"
		elog "${PN} executable that will need other files in order to be useful.."
		elog "Please consider installing a recent TeX distribution"
		elog "like TeX Live 2008 to get the full power of ${PN}"
	fi
	if [ "$ROOT" = "/" ] && [ -x /usr/bin/fmtutil-sys ] ; then
		einfo "Rebuilding formats"
		/usr/bin/fmtutil-sys --all &> /dev/null
	else
		ewarn "Cannot run fmtutil-sys for some reason."
		ewarn "Your formats might be inconsistent with your installed ${PN} version"
		ewarn "Please try to figure what has happened"
	fi
}
