# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/MaskRay/ccls.git"

inherit cmake-utils git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/MaskRay/ccls/"
#SRC_URI="https://github.com/MaskRay/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/rapidjson
	sys-devel/clang"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DLLVM_ENABLE_RTTI=ON
		-DCMAKE_CXX_COMPILER=$(tc-getCXX)
	)
	cmake-utils_src_configure
}
