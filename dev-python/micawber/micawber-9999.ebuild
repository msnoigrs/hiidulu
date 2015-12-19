# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4,3_5} )

EGIT_REPO_URI="https://github.com/coleifer/micawber.git"

inherit distutils-r1 git-2

DESCRIPTION="A small library for extracting rich content from urls"
HOMEPAGE="http://micawber.readthedocs.org/en/latest/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""
