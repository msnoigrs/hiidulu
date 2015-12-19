# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

EGIT_REPO_URI="https://github.com/masayuko/python-feedgen.git"
EGIT_BRANCH="for-pr"

inherit distutils-r1 git-2

DESCRIPTION="Python module to generate ATOM feeds, RSS feeds and Podcasts."
HOMEPAGE="https://github.com/lkiesow/python-feedgen"

LICENSE="|| ( LGPL-3+ BSD-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/lxml
	dev-python/python-dateutil"
RDEPEND="${DEPEND}"

#python_prepare_all() {
	#epatch "${FILESDIR}/ext.patch"
#	distutils-r1_python_prepare_all
#}
