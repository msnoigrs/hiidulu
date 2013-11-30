# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

EGIT_REPO_URI="https://github.com/thruflo/beaker_extensions.git"

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
	sed -i -e '/import urlparse/ a try:\n    from urlparse import urlparse\nexcept ImportError:\n    from urllib.parse import urlparse\n' -e '/^from urlparse/ d' beaker_extensions/nosql.py
	distutils-r1_python_prepare_all
}
