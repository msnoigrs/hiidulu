# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit elisp cvs autotools

ECVS_SERVER="mmm-mode.cvs.sourceforge.net:/cvsroot/mmm-mode"
ECVS_MODULE="mmm-mode"

DESCRIPTION="Enables the user to edit different parts of a file in different major modes"
HOMEPAGE="http://mmm-mode.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

SITEFILE=50${PN}-gentoo.el

S="${WORKDIR}/${PN}"


src_prepare() {
	epatch ${FILESDIR}/${PN}-0.4.8-format-mode-line.patch
	eautoreconf
}

src_configure() {
	econf --with-emacs
}

src_install() {
	elisp-install ${PN} *.el *.elc || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	#doinfo *.info* || die
	dodoc AUTHORS ChangeLog FAQ NEWS README README.Mason TODO
}
