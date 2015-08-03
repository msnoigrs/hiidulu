# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="http://altrepo.eu/git/purple-line.git"

inherit autotools git-2

DESCRIPTION="LINE protocol plugin for libpurple"
HOMEPAGE="http://altrepo.eu/git/purple-line"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/thrift
	 net-im/pidgin"
DEPEND="${RDEPEND}"
