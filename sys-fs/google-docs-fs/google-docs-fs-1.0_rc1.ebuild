# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="A filesystem to access Google Docs using any computer"
HOMEPAGE="http://code.google.com/p/google-docs-fs/"
SRC_URI="http://google-docs-fs.googlecode.com/files/${PN}-1.0rc1.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/gdata-2.0.14
	>=dev-python/fuse-python-0.2.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
