# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

#EGIT_REPO_URI="https://github.com/masayuko/astodi.git"
EGIT_REPO_URI="https://masayuko@bitbucket.org/masayuko/astodi.git"

inherit distutils-r1 git-r3

DESCRIPTION="A tool for creating diagram images from ascii art"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/masayuko/astodi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/lxml"
RDEPEND="${DEPEND}"
