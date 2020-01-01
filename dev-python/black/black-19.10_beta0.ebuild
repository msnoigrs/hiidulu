# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="The uncompromising Python code formatter"
HOMEPAGE="https://github.com/python/black"
SRC_URI="https://github.com/psf/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/toml
	dev-python/appdirs
	dev-python/attrs
	dev-python/click
	dev-python/typed-ast
	dev-python/pathspec
	dev-python/typing-extensions
	dev-python/mypy_extensions
	dev-python/aiohttp
	dev-python/aiohttp-cors"
RDEEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=( "${FILESDIR}/${PN}-${MY_PV}-no-scm.patch" )
