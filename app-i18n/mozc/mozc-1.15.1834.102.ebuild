# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit elisp-common eutils multilib multiprocessing python-single-r1 toolchain-funcs

DESCRIPTION="The Mozc engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/mozc/"

PROTOBUF_VER="r536"
GMOCK_VER="r471"
GTEST_VER="r681"
JSONCPP_VER="0.6.0-rc2"
GYP_REV="r1948"
JUDIC_REV="r10"
# svn export http://protobuf.googlecode.com/svn/trunk@536 protobuf-r536 --revision 536 --non-interactive --ignore-externals
# svn export http://japanese-usage-dictionary.googlecode.com/svn/trunk@10 japanese-usage-dictionary-r10
# svn export http://gyp.googlecode.com/svn/trunk@1948 gyp-r1948 --revision 1948 --non-interactive --ignore-externals
# svn export http://googlemock.googlecode.com/svn/trunk@471 gmock-r471 --revision 471 --non-interactive --ignore-externals
# svn export http://googletest.googlecode.com/svn/trunk@681 gtest-r681 --revision 681 --non-interactive --ignore-externals
MOZC_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/${P}.tar.bz2"
PROTOBUF_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/protobuf-${PROTOBUF_VER}.tar.bz2"
#GMOCK_URL="https://googlemock.googlecode.com/files/gmock-${GMOCK_VER}.zip"
GMOCK_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/gmock-${GMOCK_VER}.tar.bz2"
#GTEST_URL="https://googletest.googlecode.com/files/gtest-${GTEST_VER}.zip"
GTEST_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/gtest-${GTEST_VER}.tar.bz2"
JSONCPP_URL="mirror://sourceforge/jsoncpp/jsoncpp-src-${JSONCPP_VER}.tar.gz"
GYP_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/gyp-${GYP_REV}.tar.bz2"
JUDIC_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/japanese-usage-dictionary-${JUDIC_REV}.tar.bz2"
FCITX_URL="http://dev.gentoo.gr.jp/~igarashi/distfiles/mozc-fcitx-37d1760.tar.bz2"
SRC_URI="${MOZC_URL} ${PROTOBUF_URL} ${JUDIC_URL} ${GYP_URL}
	test? ( ${GMOCK_URL} ${GTEST_URL} ${JSONCPP_URL} )
	fcitx? ( ${FCITX_URL} )"

LICENSE="Apache-2.0 BSD Boost-1.0 ipadic public-domain unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs fcitx +ibus +qt4 renderer test"

RDEPEND="dev-libs/glib:2
	x11-libs/libxcb
	dev-libs/protobuf
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	renderer? ( x11-libs/gtk+:2 )
	qt4? (
		dev-qt/qtgui:4
		app-i18n/zinnia
	)
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-util/ninja
	virtual/pkgconfig"

BUILDTYPE="${BUILDTYPE:-Release}"

RESTRICT="test"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack $(basename ${MOZC_URL})

	unpack $(basename ${GYP_URL})
	mv gyp-${GYP_REV} "${S}"/third_party/gyp || die

	unpack $(basename ${PROTOBUF_URL})
	mv protobuf-${PROTOBUF_VER} "${S}"/third_party/protobuf || die

	unpack $(basename ${JUDIC_URL})
	mv japanese-usage-dictionary-${JUDIC_REV} "${S}"/third_party/japanese_usage_dictionary || die

	if use fcitx; then
		cd "${S}"
		unpack $(basename ${FCITX_URL})
	fi

	if use test; then
		cd "${S}"/third_party
		unpack $(basename ${GMOCK_URL}) $(basename ${GTEST_URL}) \
			$(basename ${JSONCPP_URL})
		mv gmock-${GMOCK_VER} gmock || die
		mv gtest-${GTEST_VER} gtest || die
		mv jsoncpp-src-${JSONCPP_VER} jsoncpp || die
	fi
}

src_prepare() {
	epatch_user
}

src_configure() {
	local myconf="--server_dir=/usr/$(get_libdir)/mozc"

	if ! use qt4 ; then
		myconf+=" --noqt"
		export GYP_DEFINES="use_libzinnia=0"
	fi

	if ! use renderer ; then
		export GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"
	fi

	export GYP_DEFINES="${GYP_DEFINES} use_libprotobuf=1"

	"${PYTHON}" build_mozc.py gyp ${myconf} --gypdir="$(pwd)/third_party/gyp" || die "gyp failed"
}

src_compile() {
	tc-export CC CXX AR AS RANLIB LD

	local my_makeopts=$(makeopts_jobs)
	# This is for a safety. -j without a number, makeopts_jobs returns 999.
	local myjobs=-j${my_makeopts/999/1}
	#myjobs="--jobs=1"

	local mytarget="server/server.gyp:mozc_server"
	use emacs && mytarget="${mytarget} unix/emacs/emacs.gyp:mozc_emacs_helper"
	use fcitx && mytarget="unix/fcitx/fcitx.gyp:fcitx-mozc ${mytarget}"
	use ibus && mytarget="unix/ibus/ibus.gyp:ibus_mozc ${mytarget}"
	use renderer && mytarget="${mytarget} renderer/renderer.gyp:mozc_renderer"
	if use qt4 ; then
		export QTDIR="${EPREFIX}/usr"
		mytarget="${mytarget} gui/gui.gyp:mozc_tool"
	fi

	#V=1 "${PYTHON}" build_mozc.py build_tools -c "${BUILDTYPE}" ${myjobs} || die
	QTDIR="" V=1 "${PYTHON}" build_mozc.py gyp || die
	V=1 "${PYTHON}" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} ${myjobs} || die

	if use emacs ; then
		elisp-compile unix/emacs/*.el || die
	fi
}

src_test() {
	tc-export CC CXX AR AS RANLIB LD
	V=1 "${PYTHON}" build_mozc.py runtests -c "${BUILDTYPE}" || die
}

src_install() {
	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper" || die
		elisp-install ${PN} unix/emacs/*.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN} || die
	fi

	if use fcitx; then
		exeinto /usr/$(get_libdir)/fcitx || die
		doexe "out_linux/${BUILDTYPE}/fcitx-mozc.so" || die
		insinto /usr/share/fcitx/addon || die
		doins "unix/fcitx/fcitx-mozc.conf" || die
		insinto /usr/share/fcitx/inputmethod || die
		doins "unix/fcitx/mozc.conf" || die
		insinto /usr/share/fcitx/mozc/icon || die
		(
			cd data/images
			newins product_icon_32bpp-128.png mozc.png || die
			cd unix
			for f in ui-*
			do
				newins ${f} "mozc-${f/ui-}" || die
			done
		)
		for mofile in out_linux/${BUILDTYPE}/gen/unix/fcitx/po/*.mo
		do
			filename=`basename $mofile` || die
			lang=${filename/.mo/} || die
			insinto /usr/share/locale/$lang/LC_MESSAGES/ || die
			newins ${mofile} fcitx-mozc.mo || die
		done
	fi

	if use ibus ; then
		exeinto /usr/libexec || die
		newexe "out_linux/${BUILDTYPE}/ibus_mozc" ibus-engine-mozc || die
		insinto /usr/share/ibus/component || die
		doins "out_linux/${BUILDTYPE}/gen/unix/ibus/mozc.xml" || die
		insinto /usr/share/ibus-mozc || die
		(
			cd data/images/unix
			newins ime_product_icon_opensource-32.png product_icon.png || die
			for f in ui-*
			do
				newins ${f} ${f/ui-} || die
			done
		)

	fi

	exeinto "/usr/$(get_libdir)/mozc" || die
	doexe "out_linux/${BUILDTYPE}/mozc_server" || die

	if use qt4 ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_tool" || die
	fi

	if use renderer ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_renderer" || die
	fi
}

pkg_postinst() {
	if use emacs ; then
		elisp-site-regen
		elog "You can use mozc-mode via LEIM (Library of Emacs Input Method)."
		elog "Write the following settings into your init file (~/.emacs.d/init.el"
		elog "or ~/.emacs) in order to use mozc-mode by default, or you can call"
		elog "\`set-input-method' and set \"japanese-mozc\" anytime you have loaded"
		elog "mozc.el"
		elog
		elog "  (require 'mozc)"
		elog "  (set-language-environment \"Japanese\")"
		elog "  (setq default-input-method \"japanese-mozc\")"
		elog
		elog "Having the above settings, just type C-\\ which is bound to"
		elog "\`toggle-input-method' by default."
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
