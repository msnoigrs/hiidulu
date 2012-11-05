# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/kiwanami/emacs-window-manager.git"

inherit elisp git-2

DESCRIPTION="Directory Explorer for GNU Emacs"
HOMEPAGE="https://github.com/kiwanami/emacs-window-manager"
SRC_URI=""

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	rm test-e2wm-pst-class.el
}
