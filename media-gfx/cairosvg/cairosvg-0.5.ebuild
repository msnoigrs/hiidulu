# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

MY_PN=CairoSVG
MY_P=${MY_PN}-${PV}

DESCRIPTION="A simple cairo based SVG converter with support for PDF, PostScript and PNG formats"
HOMEPAGE="http://cairosvg.org/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/lxml
	dev-python/pycairo
	dev-python/tinycss"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

#DOCS="NEWS.rst README.rst TODO.rst"
