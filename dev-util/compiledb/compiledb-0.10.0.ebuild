# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="compilation-database clang c cpp makefile rtags completion"
HOMEPAGE="https://github.com/nickdiego/compiledb"
SRC_URI="https://github.com/nickdiego/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# DEPEND="""
# RDEEND="${DEPEND}"
