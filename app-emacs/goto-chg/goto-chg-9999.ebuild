# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/martinp26/goto-chg.git"

inherit elisp git-2

DESCRIPTION="emacs package for going to previous locations of modifications"
HOMEPAGE="https://github.com/martinp26/goto-chg"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
	elisp-site-regen
}
