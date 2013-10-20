# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Character encoding auto-detection in Python."
HOMEPAGE="http://chardet.feedparser.org/ http://code.google.com/p/chardet/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

HTML_DOCS=( docs/ )

src_unpack() {
	# Workaround for bug 459096.
	mkdir ${P} || die
	cd ${P} || die
	unpack ${A}
}

src_prepare() {
	cd ${S}
	cp -a "${P}" "python3-${P}"

	cd "${S}/${P}"
	epatch "${FILESDIR}"/cp932.patch

	cd "${S}/python3-${P}"
	epatch "${FILESDIR}"/python3.patch
	epatch "${FILESDIR}"/python3-cp932.patch

	distutils-r1_src_prepare
}

select_source() {
	if [[ ${EPYTHON} == python3* ]]; then
		cd "${S}/python3-${P}" || die
	else
		cd "${S}/${P}" || die
	fi
}

python_compile() {
	select_source
	distutils-r1_python_compile
}

python_install() {
	select_source
	distutils-r1_python_install
}

python_install_all() {
	select_source
	distutils-r1_python_install_all
}
