# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
NEED_EMACS=24

EGIT_REPO_URI="https://code.orgmode.org/bzg/org-mode.git"

inherit elisp git-r3

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
#SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-macos"
IUSE=""

ELISP_REMOVE="lisp/org-install.el"
SITEFILE="50${PN}-gentoo-7.8.03.el"

src_compile() {
	emake datadir="${SITEETC}/${PN}"
}

src_install() {
	emake \
		prefix="${ED}/usr" \
		lispdir="${ED}${SITELISP}/${PN}" \
		datadir="${ED}${SITEETC}/${PN}" \
		infodir="${ED}/usr/share/info" \
		install

	cp "${FILESDIR}/${SITEFILE}" "${T}/${SITEFILE}"

	elisp-site-file-install "${T}/${SITEFILE}" || die
	doinfo doc/*.info
	dodoc README
}
