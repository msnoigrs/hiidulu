# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Natural Language Toolkit"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://nltk.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-python/numpy
	dev-python/pyyaml"
DEPEND="${RDEPEND}
	app-arch/unzip"
