# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/kvesteri/sqlalchemy-utils.git"

inherit distutils-r1 git-r3

DESCRIPTION="Various utility functions and custom data types for SQLAlchemy"
HOMEPAGE="https://github.com/kvesteri/sqlalchemy-utils"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/sqlalchemy"
RDEPEND="${DEPEND}"
