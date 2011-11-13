# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
NEED_EMACS=22

inherit elisp

DESCRIPTION="A derived Emacs mode implementing most of the C# rules"
HOMEPAGE="http://code.google.com/p/csharpmode/"
#SRC_URI="http://csharpmode.googlecode.com/files/CsharpToolsForEmacs.2011may13.zip
#	http://csharpmode.googlecode.com/files/${P}.el"
SRC_URI="http://csharpmode.googlecode.com/files/${P}.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

#S="${WORKDIR}"

src_unpack() {
#	elisp_src_unpack
	cp ${DISTDIR}/${P}.el ${WORKDIR}/${PN}.el
}

src_prepare() {
	epatch "${FILESDIR}"/byte-compile-fix.patch
#	rm aspx-mode.el \
#		csharp-shell.el \
#		flymake-for-csharp.el \
#		tfs.el \
#		csharp-completion.el || die "unable to remove"
}
