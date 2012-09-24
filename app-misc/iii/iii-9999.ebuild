# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/hacker/iii.git"
WANT_AUTOMAKE="1.8"

inherit git-2 autotools

DESCRIPTION="Eye-Fi manager"
HOMEPAGE="http://kin.klever.net/iii"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-apps/util-linux
	sys-devel/gettext
	app-arch/libarchive
	net-libs/gsoap
	dev-libs/confuse"
RDEPEND="${DEPEND}
	dev-db/sqlite"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-debug
}

src_compile() {
	emake builddir="${S}/src"
}

src_install() {
	emake install builddir="${S}/src" DESTDIR="${D}"
	insinto /etc/iii
	doins ${FILESDIR}/000000000000.conf
}
