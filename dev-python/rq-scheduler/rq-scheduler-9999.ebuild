# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

EGIT_REPO_URI="https://github.com/ui/rq-scheduler.git"

inherit distutils-r1 git-2

DESCRIPTION="A light library that adds job scheduling capabilities to RQ"
HOMEPAGE="https://github.com/ui/rq-scheduler"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

DEPEND="net-misc/rq"
RDEPEND="${DEPEND}"
