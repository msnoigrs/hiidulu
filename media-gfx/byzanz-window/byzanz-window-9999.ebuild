# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

#EGO_SRC=github.com/syohex/${PN}
#EGO_PN=${EGO_SRC}/...
EGO_PN="github.com/syohex/${PN}"
#EGIT_REPO_URI="https://github.com/syohex/byzanz-window.git"

inherit golang-vcs golang-build

DESCRIPTION="Go Port ob byzanz_window.py"
HOMEPAGE="https://${EGO_SRC}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
COMMON_DEP="x11-libs/libX11"
DEPEND=">=dev-lang/go-1.4:=
	dev-go/pflag
	${COMMON_DEP}"
RDEPEND="${COMMON_DEP}
	media-gfx/byzanz
	x11-misc/xdotool
	x11-apps/xprop
	x11-apps/xwininfo"

src_prepare() {
	cd "${WORKDIR}/${P}/src/${EGO_PN%/...}"
	mkdir byzanz
	mv select_rectangle.go byzanz
	mv select_rectangle_linux.go byzanz
	sed -i -e 's#github.com/syohex/byzanz-window#github.com/syohex/byzanz-window/byzanz#' cmd/${PN}/${PN}.go
	mv cmd/${PN}/${PN}.go .
	rm wercker.yml
}

src_install() {
	dobin ${PN}
}
