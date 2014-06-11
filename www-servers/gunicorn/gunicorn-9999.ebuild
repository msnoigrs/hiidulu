# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

EGIT_REPO_URI="https://github.com/benoitc/gunicorn.git"

inherit distutils-r1 git-2

DESCRIPTION="A WSGI HTTP Server for UNIX"
HOMEPAGE="http://gunicorn.org http://pypi.python.org/pypi/gunicorn"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"
KEYWORDS="~amd64 ~x86"

RDEPEND="python_targets_python3_3? ( dev-python/aiohttp[python_targets_python3_3] )
	python_targets_python3_4? ( dev-python/aiohttp[python_targets_python3_4] )
	dev-python/setproctitle"
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/pytest )"

DOCS="README.rst"

python_prepare() {
	# these tests requires an already installed version of gunicorn
	rm tests/test_003-config.py

	sed -ie "s/..\/bin/\/usr\/bin\//" docs/Makefile || die

	distutils-r1_python_prepare
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	py.test -v || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )

	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${P}
		doins -r examples
	fi
}
