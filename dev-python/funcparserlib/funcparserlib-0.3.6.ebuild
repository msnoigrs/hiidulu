# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Recursive descent parsing library based on functional combinators"
HOMEPAGE="http://code.google.com/p/funcparserlib/"
SRC_URI="http://pypi.python.org/packages/source/f/funcparserlib/funcparserlib-0.3.6.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
