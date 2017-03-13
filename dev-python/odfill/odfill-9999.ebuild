# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5,3_6} )

EGIT_REPO_URI="https://masayuko@bitbucket.org/masayuko/odfill.git"

inherit distutils-r1 git-r3

DESCRIPTION="jbax demo"
HOMEPAGE="https://github.com/masayuko/odfill"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/toml"
RDEPEND="${DEPEND}"
