# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11."
HOMEPAGE="http://p11-glue.freedesktop.org/p11-kit.html"
SRC_URI="http://p11-glue.freedesktop.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="debug"

src_prepare() {
	sed -i -e 's/PTHREAD_MUTEX_RECURSIVE/PTHREAD_MUTEX_RECURSIVE_NP/' p11-kit/compat.c
}

src_configure() {
	econf \
		$(use_enable debug)
}
