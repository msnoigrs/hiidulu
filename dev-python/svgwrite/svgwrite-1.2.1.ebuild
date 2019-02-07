# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="A Python library to create SVG drawings"
SRC_URI="https://github.com/mozman/svgwrite/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
HOMEPAGE="https://bitbucket.org/mozman/svgwrite"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""
