# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DEBPKGD="imagescan-bundle-ubuntu-19.10-${PV}.x64.deb"

DESCRIPTION="EPSON Image Scan v3 for Linux"
HOMEPAGE="http://support.epson.net/linux/en/imagescanv3.php"
SRC_URI="http://support.epson.net/linux/src/scanner/imagescanv3/common/imagescan_${PV}.orig.tar.gz
https://download2.ebz.epson.net/imagescanv3/ubuntu/latest1/deb/x64/${DEBPKGD}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE="graphicsmagick gui imagemagick"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boost:=
	media-gfx/sane-backends
	media-libs/tiff
	virtual/libusb:1
	virtual/jpeg
	gui? ( dev-cpp/gtkmm:2.4 )
	imagemagick? (
		!graphicsmagick? ( media-gfx/imagemagick:= )
		graphicsmagick? ( media-gfx/graphicsmagick:= )
	)
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/deb2targz"

S="${WORKDIR}/utsushi-0.$(ver_cut 2-3)"

PATCHES=(
	"${FILESDIR}"/${PN}-3.61.0-ijg-libjpeg.patch
	"${FILESDIR}"/${PN}-3.61.0-imagemagick-7.patch
)

plugin_unpack() {
	mkdir ${1}
	cd ${1}
	unpack "${WORKDIR}/${DEBPKGD}/plugins/${1}-1epson4ubuntu19.10_amd64.deb"
	unpack "${WORKDIR}/${1}/data.tar.xz"
	cd ..
}

src_unpack() {
	default
	plugin_unpack imagescan-plugin-gt-s650_1.0.2
	plugin_unpack imagescan-plugin-networkscan_1.1.3
	plugin_unpack imagescan-plugin-ocr-engine_1.0.2
}

src_configure() {
	econf \
		$(use_with gui gtkmm) \
		--with-jpeg \
		$(use_with imagemagick magick) \
		$(use_with imagemagick magick-pp) \
		--with-tiff \
		--with-sane \
		--with-boost=yes
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die

	#insinto /usr/libexec/utsushi
	exeinto /usr/lib64/utsushi
	doexe ${WORKDIR}/imagescan-plugin-gt-s650_1.0.2/usr/lib/x86_64-linux-gnu/utsushi/libcnx-esci-gt-s650.so.0.0.0
	dosym libcnx-esci-gt-s650.so.0.0.0 /usr/lib64/utsushi/libcnx-esci-gt-s650.so
	dosym libcnx-esci-gt-s650.so.0.0.0 /usr/lib64/utsushi/libcnx-esci-gt-s650.so.0
	dodir /usr/libexec/utsushi
	dosym esci-interpreter /usr/libexec/utsushi/esci-gt-s650

	insinto /usr/share/utsushi
	doins ${WORKDIR}/imagescan-plugin-gt-s650_1.0.2/usr/share/utsushi/esfw010c.bin

	exeinto /usr/libexec/utsushi
	doexe ${WORKDIR}/imagescan-plugin-networkscan_1.1.3/usr/lib/utsushi/networkscan

	names="bmpmem cnvres colbin ijglib imgmem lngdic memjpg ocrsys rotmem skwmem usrdic ydblock ydcorr ydline ydocrd ydprof ydrecxx ydstyle ydtable"
	exeinto /usr/lib64/utsushi
	for n in ${names}
	do
		doexe ${WORKDIR}/imagescan-plugin-ocr-engine_1.0.2/usr/lib/x86_64-linux-gnu/utsushi/libocr-${n}.so.0.0.0
		dosym libocr-${n}.so.0.0.0 /usr/lib64/utsushi/libocr-${n}.so
		dosym libocr-${n}.so.0.0.0 /usr/lib64/utsushi/libocr-${n}.so.0
	done

	exeinto /usr/libexec/utsushi
	doexe ${WORKDIR}/imagescan-plugin-ocr-engine_1.0.2/usr/lib/x86_64-linux-gnu/utsushi/ocr-engine-getrotate

	insinto /usr/share/utsushi/ocr/dic
	doins ${WORKDIR}/imagescan-plugin-ocr-engine_1.0.2/usr/share/utsushi/ocr/dic/Rotate.ptn

	elog "If you encounter problems with media-gfx/xsane when scanning (e.g., bad resolution),"
	elog "please try the built-in GUI and kde-misc/skanlite first before reporting bugs."
}
