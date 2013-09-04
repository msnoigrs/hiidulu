# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://repo.or.cz/anything-config.git"

inherit elisp git-2

DESCRIPTION="Open anything - QuickSilver-like candidate-selection framework"
HOMEPAGE="http://www.emacswiki.org/emacs/Anything"
# snapshot from http://repo.or.cz/w/anything-config.git
#SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extensions"

S="${WORKDIR}/anything-config"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-compile *.el || die
	elisp-make-autoload-file || die

	if use extensions; then
		BYTECOMPFLAGS="-L . -L extensions" elisp-compile extensions/*.el || die
	fi
}

src_install() {
	elisp-install ${PN} *.{el,elc} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	if use extensions; then
		elisp-install ${PN} extensions/*.{el,elc} || die
	fi

	dodoc README doc/anything.pdf
}
