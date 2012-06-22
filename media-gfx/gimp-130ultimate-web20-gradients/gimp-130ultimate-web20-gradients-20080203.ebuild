# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="130 Ultimate Web 2.0 Gradients for Gimp"
HOMEPAGE="http://gimp-tutorials.net/130-UltimateWeb20-Gradients-for-Gimp"
SRC_URI="http://gimp-tutorials.net/files/130-UltimateWeb2-0-Gradients-for-Gimp.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /usr/share/gimp/2.0/gradients
	for i in gradients/*.ggr; do
		doins "${i}"
	done
}
