# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

MY_P="${PN}-${PV/_beta/b}"
DESCRIPTION="The updated configparser from Python 3.5 to Python 2.6-3.5"
HOMEPAGE="http://pypi.python.org/pypi/configparser/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"
