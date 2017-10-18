# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GOLANG_PKG_IMPORTPATH="github.com/syohex"
GOLANG_PKG_VERSION="7c692ca40eb90c2c2b030b29a8bd91c535381b46"
GOLANG_PKG_USE_CGO=1

GOLANG_PKG_DEPENDENCIES=(
	"github.com/ogier/pflag:45c278a"
)

inherit golang-single

DESCRIPTION="Go Port ob byzanz_window.py"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
COMMON_DEP="x11-libs/libX11"
DEPEND="${COMMON_DEP}"
RDEPEND="${COMMON_DEP}
	media-gfx/byzanz
	x11-misc/xdotool
	x11-apps/xprop
	x11-apps/xwininfo"

src_prepare() {
	golang-single_src_prepare
	cd ${WORKDIR}/gopath/src/github.com/syohex/byzanz-window
	mkdir byzanz
	#mv select_rectangle.go byzanz
	mv select_rectangle_linux.go byzanz
	rm select_rectangle.go
	#rm select_rectangle_linux.go
	sed -i -e 's#github.com/syohex/byzanz-window#github.com/syohex/byzanz-window/byzanz#' cmd/${PN}/${PN}.go || die
	mv cmd/${PN}/${PN}.go .
	rm wercker.yml
}
