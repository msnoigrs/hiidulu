# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="An implementation of the Language Server Protocol for Python"
HOMEPAGE="https://github.com/palantir/python-language-server"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/palantir/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/future[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/futures' python2_7)
	dev-python/jedi[${PYTHON_USEDEP}]
	dev-python/python-jsonrpc-server[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/autopep8[${PYTHON_USEDEP}]
	dev-python/mccabe[${PYTHON_USEDEP}]
	dev-python/pycodestyle[${PYTHON_USEDEP}]
	dev-python/pydocstyle[${PYTHON_USEDEP}]
	dev-python/pyflakes[${PYTHON_USEDEP}]
	dev-python/rope[${PYTHON_USEDEP}]
	dev-python/yapf[${PYTHON_USEDEP}]
	test? (
		dev-python/tox[${PYTHON_USEDEP}]
		dev-python/versioneer[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

python_prepare_all() {
	rm -r test || die
	distutils-r1_python_prepare_all
}

python_test() {
	pytest -vv || die "Tests failed under ${EPYTHON}"
}
