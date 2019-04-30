# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

COMMIT="cea13f498418784e22f8fbd78db3f9240a2bad11"

DESCRIPTION="The uncompromising Python code formatter"
HOMEPAGE="https://github.com/ambv/black"
SRC_URI="https://github.com/ambv/${PN}/archive/${COMMIT}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/toml
	dev-python/appdirs
	dev-python/attrs
	dev-python/click
	dev-python/aiohttp
	dev-python/aiohttp-cors"
RDEEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"
