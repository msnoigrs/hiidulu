# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/pygraphviz/pygraphviz.git"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit git-2 distutils-r1

DESCRIPTION="Python wrapper for the Graphviz Agraph data structure"
HOMEPAGE="http://networkx.lanl.gov/pygraphviz/ http://pypi.python.org/pypi/pygraphviz"
#SRC_URI="http://networkx.lanl.gov/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

# Note: only C API of graphviz is used, PYTHON_USEDEP unnecessary.
RDEPEND="media-gfx/graphviz"
DEPEND="dev-lang/swig
		${RDEPEND}"

#PATCHES=(
#	"${FILESDIR}"/setup.patch
#)
#	"${FILESDIR}"/${PN}-1.0-setup.py.patch
#	"${FILESDIR}"/${P}-avoid_tests.patch

src_prepare() {
	distutils-r1_src_prepare
	cd pygraphviz
	swig -python -o graphviz_wrap.c graphviz.i
}

python_test() {
	PYTHONPATH=${PYTHONPATH}:${BUILD_DIR}/lib/pygraphviz \
	"${PYTHON}" \
		-c "import pygraphviz.tests; pygraphviz.tests.run()" \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
