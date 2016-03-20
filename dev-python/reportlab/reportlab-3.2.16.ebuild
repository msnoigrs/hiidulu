# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )
# Tests crash with pypy

inherit distutils-r1 flag-o-matic prefix

DESCRIPTION="Tools for generating printable PDF documents from any data source"
HOMEPAGE="http://www.reportlab.com/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${PN}-3.2.0.tar.gz
	http://www.reportlab.com/ftp/fonts/pfbfer-20070710.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/pip-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools-2.2[${PYTHON_USEDEP}]
	media-fonts/dejavu
	media-libs/libart_lgpl
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	app-arch/unzip
"

src_unpack() {
	unpack ${PN}-3.2.0.tar.gz
	mv ${PN}-3.2.0 ${P}
	cd ${P}/src/reportlab/fonts || die
	unpack pfbfer-20070710.zip
}

python_prepare_all() {
	epatch "${FILESDIR}/3.2.16.patch"

	sed -i \
		-e "s|/usr/lib/X11/fonts/TrueType/|${EPREFIX}/usr/share/fonts/dejavu/|" \
		-e 's|/usr/local/Acrobat|/opt/Acrobat|g' \
		-e 's|%(HOME)s/fonts|%(HOME)s/.fonts|g' \
		src/reportlab/rl_config.py || die

	eprefixify setup.py
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_compile() {
	if ! python_is_python3; then
		local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	fi
	distutils-r1_python_compile
}

python_test() {
	pushd tests > /dev/null || die
	"${PYTHON}" runAll.py || die "Testing failed with ${EPYTHON}"
	popd > /dev/null || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	use examples && local EXAMPLES=( demos/. tools/pythonpoint/demos )

	distutils-r1_python_install_all
}
