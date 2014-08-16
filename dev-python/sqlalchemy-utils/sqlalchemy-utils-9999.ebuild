# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

EGIT_REPO_URI="https://github.com/kvesteri/sqlalchemy-utils.git"

inherit distutils-r1 git-2

DESCRIPTION="Various utility functions and custom data types for SQLAlchemy"
HOMEPAGE="https://github.com/kvesteri/sqlalchemy-utils"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/sqlalchemy"
RDEPEND="${DEPEND}"
