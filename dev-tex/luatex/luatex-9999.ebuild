# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

ESVN_REPO_URI="https://foundry.supelec.fr/svn/luatex/trunk"
ESVN_USER="anonsvn"
ESVN_PASSWORD="anonsvn"

inherit subversion libtool eutils

DESCRIPTION="An extended version of pdfTeX using Lua as an embedded scripting language."
HOMEPAGE="http://www.luatex.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc"

RDEPEND="dev-libs/zziplib
	>=media-libs/libpng-1.4
	>=app-text/poppler-0.12.3-r3[xpdf-headers(+)]
	sys-libs/zlib
	>=dev-libs/kpathsea-6.0.1_p20110627"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	cd source
	chmod +x ./texk/web2c/luatexdir/getluatexsvnversion.sh
	./texk/web2c/luatexdir/getluatexsvnversion.sh
	S="${S}/source/build-aux" elibtoolize --shallow
}

src_configure() {
	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #244619
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

	cd "${S}/source/libs/lua52"
	econf --disable-largefile --enable-static

	cd "${S}/source/libs/luajit"
	econf --disable-largefile --enable-static

	cd "${S}/source/texk/web2c"
	econf \
		--disable-cxx-runtime-hack \
		--disable-all-pkgs	\
		--disable-shared	\
		--disable-largefile \
		--disable-ptex		\
		--disable-ipc		\
		--enable-dump-share	\
		--enable-mp		\
		--enable-luatex		\
		--enable-luajittex		\
		--without-system-luajit \
		--without-mf-x-toolkit \
		--with-system-cairo \
		--with-system-pixman \
		--with-system-gmp \
		--with-system-mpfr \
		--with-system-ptexenc \
		--with-system-kpathsea	\
		--with-kpathsea-includes="${EPREFIX}"/usr/include \
		--with-system-poppler \
		--with-system-xpdf \
		--with-system-freetype2 \
		--with-system-gd	\
		--with-system-libpng	\
		--with-system-teckit \
		--with-system-zlib \
		--with-system-t1lib \
		--with-system-icu \
		--with-system-graphite2 \
		--with-system-harfbuzz \
		--with-system-zziplib \
		--without-mf-x-toolkit \
		--without-x || die "failed to configure"
}

src_compile() {
	cd "${S}/source/libs/lua52"
	emake

	cd "${S}/source/libs/luajit"
	emake

	cd "${S}/source/texk/web2c"
	emake luatex luajittex
}

src_install() {
	cd "${S}/source/texk/web2c"
	emake DESTDIR="${D}" bin_PROGRAMS="luatex" SUBDIRS="" nodist_man_MANS="" \
		install-exec-am || die
	emake DESTDIR="${D}" bin_PROGRAMS="luajittex" SUBDIRS="" nodist_man_MANS="" \
		install-exec-am || die

#	dobin source/texk/web2c/luatex
#	dobin source/texk/web2c/luajittex
#	dosym /usr/bin/luatex /usr/bin/texlua
#	dosym /usr/bin/luatex /usr/bin/texluac
#	dosym /usr/bin/luajittex /usr/bin/texluajit
#	dosym /usr/bin/luajittex /usr/bin/texluajitc
}

pkg_postinst() {
	efmtutil-sys
}
