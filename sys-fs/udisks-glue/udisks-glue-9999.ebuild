# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/fernandotcl/udisks-glue.git"

inherit git-2 autotools

DESCRIPTION="A tool to associate udisks events to user-defined actions"
HOMEPAGE="http://github.com/fernandotcl/udisks-glue"
#SRC_URI="https://github.com/fernandotcl/udisks-glue/tarball/release-1.2.0 -> ${P}.tar.gz"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/dbus-glib-0.88
	dev-libs/glib:2
	dev-libs/confuse"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

#src_unpack() {
#	unpack ${A}
#	mv *-${PN}-* "${S}"
#}

src_prepare() {
	sed -i -e "s/-Werror//" src/Makefile.am
	sed -i -e "s/-Werror//" src/Makefile.in

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README
}
