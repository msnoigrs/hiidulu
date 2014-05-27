# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} )

EGIT_REPO_URI="https://github.com/miracle2k/webassets.git"

inherit distutils-r1 git-2

DESCRIPTION="Asset management for Python web development"
HOMEPAGE="http://webassets.readthedocs.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""
