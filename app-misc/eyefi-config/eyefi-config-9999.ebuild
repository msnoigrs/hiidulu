# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://git.sr71.net/eyefi-config.git"

inherit eutils toolchain-funcs git-2

DESCRIPTION="Eye-Fi Card Configuration Utility"
HOMEPAGE="http://sr71.net/projects/eyefi/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
#	sed -i -e 's/O_CREAT/O_CREAT, S_IRWXU|S_IRWXG|S_IRWXO/' eyefi-linux.c
	sed -i -e 's/O_CREAT/O_CREAT, 0600/' eyefi-linux.c
	epatch "${FILESDIR}"/firmware5.patch
}

src_compile() {
#	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin eyefi-config
}
