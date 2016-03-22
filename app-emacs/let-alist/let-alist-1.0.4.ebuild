# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit elisp

DESCRIPTION="Easily let-bind values of an assoc-list by their names"
HOMEPAGE="https://elpa.gnu.org/packages/let-alist.html"
SRC_URI="https://elpa.gnu.org/packages/let-alist-1.0.4.el"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

#SITEFILES="50${PN}-gentoo.el"

S="${WORKDIR}"

src_unpack() {
	cp ${DISTDIR}/${P}.el ${WORKDIR}/${PN}.el
}
