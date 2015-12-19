# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="https://github.com/sk1project/uniconvertor.git"

inherit git-2 distutils-r1

DESCRIPTION="Commandline tool for popular vector formats convertion"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor https://github.com/sk1project/uniconvertor"

KEYWORDS="amd64 ~arm hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~x86-solaris"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

RDEPEND="
	media-libs/lcms:2
	media-libs/freetype:2
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/reportlab"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-text/ghostscript-gpl"

python_prepare_all() {
	distutils-r1_python_prepare_all

	sed -i -e 's/^LCMS2 = False/LCMS2 = True/' setup.py

	#ln -sf \
	#	"${EPREFIX}"/usr/share/imagemagick/sRGB.icm \
	#	src/unittests/cms_tests/cms_data/sRGB.icm || die
}

python_test() {
	einfo ${PYTHONPATH}
	#distutils_install_for_testing
	cd src/unittests || die
	${EPYTHON} all_tests.py || die
}
