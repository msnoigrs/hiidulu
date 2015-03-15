# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_REPO_URI="git://github.com/mattn/gntp-send.git"

inherit git-2 autotools multilib

DESCRIPTION="command line program that send to growl using GNTP protocol."
HOMEPAGE="http://wiki.github.com/psinnott/gntp-send"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	mkdir m4
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -name '*.la' -delete
}
