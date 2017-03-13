# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

#EGIT_REPO_URI="https://github.com/thruflo/beaker_extensions.git"
EGIT_REPO_URI="https://github.com/masayuko/beaker_extensions.git"

inherit distutils-r1 git-2

DESCRIPTION="Extending beaker to use No SQL backend"
HOMEPAGE="https://github.com/thruflo/beaker_extensions"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/beaker"
RDEPEND="${DEPEND}"

python_prepare_all() {
	# don't support python 3.x yet
	rm beaker_extensions/ringogw.py
	distutils-r1_python_prepare_all
}
