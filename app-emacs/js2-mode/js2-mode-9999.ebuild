# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SIMPLE_ELISP=t

ESVN_REPO_URI="http://js2-mode.googlecode.com/svn/trunk/"

inherit elisp subversion

DESCRIPTION="An improved JavaScript mode for GNU emacs"
HOMEPAGE="http://code.google.com/p/js2-mode/"
#SRC_URI="http://${PN}-mode.googlecode.com/files/${P}.el"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	rm js2-build.el
}
