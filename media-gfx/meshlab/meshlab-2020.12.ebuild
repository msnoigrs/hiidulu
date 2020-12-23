# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils

DESCRIPTION="The open source system for processing and editing 3D triangular meshes"
HOMEPAGE="http://www.meshlab.net"
VCG_VERSION="2020.12"
SRC_URI="https://github.com/cnr-isti-vclab/meshlab/archive/Meshlab-${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cnr-isti-vclab/vcglib/archive/${VCG_VERSION}.tar.gz -> vcglib-${VCG_VERSION}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-minimal"

DEPEND="dev-cpp/eigen:3
	dev-cpp/muParser
	dev-qt/qtcore:5
	dev-qt/qtopengl:5
	dev-qt/qtscript:5
	dev-qt/qtxmlpatterns:5
	media-libs/glew:0
	media-libs/qhull
	=media-libs/lib3ds-1*
	media-libs/openctm
	sci-libs/mpir"

#	>=media-gfx/jhead-3.00-r2
#	sci-libs/levmar

RDEPEND="${DEPEND}"

S="${WORKDIR}/meshlab-Meshlab-${PV}/src"

PATCHES=(
	"${FILESDIR}/${PV}/0001-set-shader-and-texture-paths.patch"
# 	#remove ot working plugins
# 	"${FILESDIR}/${PV}/remove-edit_mutualcorrs.patch"
# 	"${FILESDIR}/${PV}/remove-io_TXT.patch"
# 	#since structure synth doesn't seem to be compiling
# 	"${FILESDIR}/${PV}/0001-disable-filter-ssynth.patch"
# 	#this has been fixed in the tree
# 	"${FILESDIR}/${PV}/0001-disable-edit-quality.patch"
# 	#this causes segfaults
# 	"${FILESDIR}/${PV}/0001-disable-filter-layer.patch"
# 	#for when we use minimal
# 	"${FILESDIR}/${PV}/0001-compile-server.patch"
# 	"${FILESDIR}/${PV}/0001-use-external-lib3ds.patch"
# 	"${FILESDIR}/${PV}/0001-use-external-openctm.patch"
# 	"${FILESDIR}/${PV}/0001-use-external-muParser.patch"
# 	"${FILESDIR}/${PV}/0001-use-external-bzip.patch"
# 	"${FILESDIR}/${PV}/0001-use-external-jhead.patch"
# 	"${FILESDIR}/${PV}/0001-use-external-glew.patch"
# 	#cause gnu stack quickstart related qa
# 	"${FILESDIR}/${PV}/0001-remove-not-sane-plugins.patch"
	"${FILESDIR}/${PV}/${P}-fix-plugins-path.patch"
#	"${FILESDIR}/${PV}/${P}-align1.patch"
#	"${FILESDIR}/${PV}/${P}-align2.patch"
# 	"${FILESDIR}/${PV}/${P}-asString.patch"
#	"${FILESDIR}/${PV}/${P}-qprintable.patch"
# 	"${FILESDIR}/${PV}/${P}-qt-includes.patch"
# 	"${FILESDIR}/${PV}/${P}-qt-5.15.patch"
)

src_prepare() {
	sed -i -e 's|/usr/lib/x86_64-linux-gnu|/usr/lib64|g' "${S}/find_system_libs.pri"
	sed -i -e '/^linux/ a CONFIG += system_muparser' "${S}/find_system_libs.pri"
	#sed -i -e '/levmar-2.3\/levmar-2.3.pro/ d' "${S}/external/external.pro"

	rmdir "${S}/vcglib" || die
	mv "${WORKDIR}/vcglib-${VCG_VERSION}" "${S}/vcglib" || die "vcglib mv failed"
	default
	#proof of patchset
	#remove libs that are being used from the system
	rm -r "external/lib3ds-1.3.0" || die "rm failed"
	rm -r "external/OpenCTM-1.0.3" || die "rm failed"
	#rm -r "external/muparser_v132" || die "rm failed"
	rm -r "external/muparser_v225" || die "rm failed"
	#rm -r "unsupported/plugins_unsupported/external/bzip2-1.0.5" || die "rm failed"
	#rm -r "external/jhead-2.95" || die "rm failed"
	#rm -r "external/glew-1.5.1" || die "rm failed"
	rm -r "external/glew-2.1.0" || die "rm failed"
	#rm -r "external/levmar-2.3" || die "rm failed"
	#rm -r "external/u3d" || die "rm failed"
	#rm -r "external/structuresynth-1.5" || die "rm failed"
	rm -r "external/qhull-2003.1" || die "rm failed"
	#we still depend on lm.h
	#rm -r "external"
	#rm -r "distrib/plugins/U3D_W32" || die
	#rm -r "distrib/plugins/U3D_OSX" || die

	# Fix bug 638796
	#cd "${WORKDIR}" || die
	#eapply "${FILESDIR}/${PV}/${P}-remove-header.patch"
}

src_configure() {
	use minimal || eqmake5 -r meshlab.pro
	use minimal && eqmake5 -r meshlab_mini.pro
}

src_install() {
	cd "${WORKDIR}/meshlab-Meshlab-${PV}"
	dobin distrib/{meshlab,meshlabserver}
	dolib.so distrib/lib/libmeshlab-common.so.1.0.0
	dosym libmeshlab-common.so.1.0.0 /usr/$(get_libdir)/libmeshlab-common.so.1
	dosym libmeshlab-common.so.1 /usr/$(get_libdir)/libmeshlab-common.so
	exeinto /usr/$(get_libdir)/meshlab/plugins
	doexe distrib/plugins/*.so
	insinto /usr/share/meshlab/shaders
	doins -r distrib/shaders/*
	insinto /usr/share/meshlab/plugins
	doins -r distrib/plugins/*
	insinto /usr/share/meshlab/textures
	doins -r textures/*
	insinto /usr/share/meshlab/sample
	doins -r sample/*
	newicon "${S}"/meshlab/images/eye512.png "${PN}".png
	make_desktop_entry meshlab "Meshlab" "${PN}" Graphics
}
