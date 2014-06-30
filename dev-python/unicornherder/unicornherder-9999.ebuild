# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

EGIT_REPO_URI="https://github.com/alphagov/unicornherder.git"

inherit distutils-r1 git-2

DESCRIPTION="manage daemonized (g)unicorns"
HOMEPAGE="https://github.com/alphagov/unicornherder"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/psutil"
RDEPEND="${DEPEND}"
