# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

COMMIT="026c81b83454f176a9f9253cbfb70be2c159d822"

DESCRIPTION="The uncompromising Python code formatter"
HOMEPAGE="https://github.com/python/black"
SRC_URI="https://github.com/python/${PN}/archive/${COMMIT}.tar.gz -> ${MY_P}.tar.gz"

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
