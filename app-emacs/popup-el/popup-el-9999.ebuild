# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/auto-complete/popup-el.git"

inherit elisp eutils git-r3

DESCRIPTION="Visual Popup Interface Library for Emacs"
HOMEPAGE="https://github.com/auto-complete/popup-el"
SRC_URI=""

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_ja"

SITEFILE="50${PN}-gentoo.el"
#ELISP_PATCHES="ajc-java-complete.patch"

src_install() {
	elisp_src_install
}
