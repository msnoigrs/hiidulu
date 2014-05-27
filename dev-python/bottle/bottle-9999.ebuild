# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy2_0)

EGIT_REPO_URI="https://github.com/defnull/bottle.git"

inherit distutils-r1 git-2

DESCRIPTION="A fast and simple micro-framework for small web-applications"
HOMEPAGE="http://pypi.python.org/pypi/bottle http://bottlepy.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ia64 ppc ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

python_prepare_all() {
	sed -i -e '/scripts/d' setup.py || die
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "Due to problems with bottle.py being in /usr/bin (see bug #474874)"
	elog "we do as most other distros and do not install the script anymore."
	elog "If you do want/have to call it directly rather than through your app,"
	elog "please use the following instead:"
	elog '  `python -m bottle`'
}
