# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} pypy pypy2_0 )

EGIT_REPO_URI="https://github.com/Pylons/peppercorn.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library for converting a token stream into a data structure for use in web form posts"
HOMEPAGE="https://github.com/Pylons/peppercorn http://pypi.python.org/pypi/peppercorn"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

# Include COPYRIGHT.txt because the license seems to require it.
DOCS=( CHANGES.rst README.rst COPYRIGHT.txt )

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all

	# Install only the .rst source, as sphinx processing requires a
	# theme only available from git that contains hardcoded references
	# to files on https://static.pylonsproject.org/ (so the docs would
	# not actually work offline). Install into a "docs" subdirectory
	# so the reference in the README remains correct.
	docinto docs
	dodoc docs/*.rst
}
