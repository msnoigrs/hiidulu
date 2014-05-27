# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

EGIT_REPO_URI="https://github.com/wrobstory/vincent.git"

inherit distutils-r1 git-2

DESCRIPTION="A Python to Vega translator"
HOMEPAGE="https://vincent.readthedocs.org/en/latest/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/pandas"
RDEPEND="${DEPEND}"
