# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	sys-devel/clang:14"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_PREFIX_PATH=/usr/lib/llvm/14/lib64/cmake
	)
	cmake-utils_src_configure
}
