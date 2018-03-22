# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/AdamNiederer/vue-mode.git"

inherit elisp git-r3

DESCRIPTION="Emacs major mode for vue.js"
HOMEPAGE="https://github.com/AdamNiederer/vue-mode"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/mmm-mode
	app-emacs/vue-html-mode
	app-emacs/ssass-mode
	app-emacs/edit-indirect"
RDEPEND="app-emacs/mmm-mode
	app-emacs/vue-html-mode
	app-emacs/ssass-mode
	app-emacs/edit-indirect"

#SITEFILE="50${PN}-gentoo.el"
