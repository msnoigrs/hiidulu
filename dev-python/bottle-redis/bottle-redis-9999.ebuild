# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

EGIT_REPO_URI="https://github.com/bottlepy/bottle-extras.git"

inherit distutils-r1 git-2

DESCRIPTION="Bottle-Redis"
HOMEPAGE="https://github.com/bottlepy/bottle-extras"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/beaker"
RDEPEND="${DEPEND}"

src_prepare() {
	cd redis
	distutils-r1_src_prepare
}

src_configure() {
	cd redis
	distutils-r1_src_configure
}

src_compile() {
	cd redis
	distutils-r1_src_compile
}

src_test() {
	cd redis
	distutils-r1_src_test
}

src_install() {
	cd redis
	distutils-r1_src_install
}
