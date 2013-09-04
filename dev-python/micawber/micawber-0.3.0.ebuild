# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A small library for extracting rich content from urls"
SRC_URI="https://pypi.python.org/packages/source/m/${PN}/${P}.tar.gz"
HOMEPAGE="http://micawber.readthedocs.org/en/latest/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""
