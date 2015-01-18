# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils udev user toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/codestation/VitaMTP.git"
	inherit git-2
else
	KEYWORDS="amd64 ~arm hppa ia64 ppc ppc64 x86 ~amd64-fbsd"
	SRC_URI="https://github.com/codestation/vitamtp/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/vitamtp-${PV}"
fi

DESCRIPTION="Library to interact with Vita's USB MTP protocol"
HOMEPAGE="https://github.com/codestation/VitaMTP"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc static-libs"

RDEPEND="virtual/libusb:1
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog README.md"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable doc doxygen)
}

src_install() {
	default
	prune_libtool_files
}
