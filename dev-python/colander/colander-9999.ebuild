# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/Pylons/colander.git"

inherit distutils-r1 git-r3

DESCRIPTION="A simple schema-based serialization and deserialization library"
HOMEPAGE="http://docs.pylonsproject.org/projects/colander/en/latest/ http://pypi.python.org/pypi/colander"

# MIT license is used by included (modified) iso8601.py code.
LICENSE="repoze MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# Depend on an ebuild of translationstring with Python 3 support.
RDEPEND=">=dev-python/translationstring-1.1[${PYTHON_USEDEP}]
	dev-python/iso8601[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove pylons theme since it's not included in source
	sed -e "/# Add and use Pylons theme/,+37d" -i docs/conf.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		# https://github.com/Pylons/colander/issues/38
		emake -C docs html SPHINXOPTS=""
	fi
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install

	insinto $(python_get_sitedir)/${PN}
	doins -r "${S}/${PN}/locale"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
