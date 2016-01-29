# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/tanakamura/waifu2x-converter-cpp.git"

inherit cmake-utils git-2

DESCRIPTION="waifu2x"
HOMEPAGE="https://github.com/tanakamura/waifu2x-converter-cpp"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/opencv"
DEPEND="${RDEPEND}"

src_configure() {
	# -D CUDA_TOOLKIT_ROOT_DIR=....
	local mycmakeargs=(
		-D INSTALL_MODELS=true
	)
	cmake-utils_src_configure
}
