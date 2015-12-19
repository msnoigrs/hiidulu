# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

#EGIT_REPO_URI="https://github.com/masayuko/astodi.git"
EGIT_REPO_URI="https://masayuko@bitbucket.org/masayuko/jbaxpack.git"

inherit distutils-r1 git-2

DESCRIPTION="jbax demo"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/masayuko/jbaxpack"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/lxml"
RDEPEND="${DEPEND}"
