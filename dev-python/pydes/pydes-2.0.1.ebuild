# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6,7}} )

MY_PN="pyDes"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="The DES and Triple-DES encryption algorithms"
HOMEPAGE="https://github.com/twhiteman/pyDes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

S="${WORKDIR}/${MY_P}"
